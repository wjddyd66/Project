# pytorch libraries
from mpl_toolkits.axes_grid1 import make_axes_locatable
import numpy as np
from PIL import Image

import torch
from torch import nn
from torch.nn import functional as F
from torchvision import models, transforms
import matplotlib.pyplot as plt

# Segmentation Model
def convrelu(in_channels, out_channels, kernel, padding):
    return nn.Sequential(
        nn.Conv2d(in_channels, out_channels, kernel, padding=padding),
        nn.ReLU(inplace=True),
    )


class ResNetUNet(nn.Module):
    def __init__(self, n_class):
        super().__init__()

        self.base_model = models.resnet18(pretrained=True)
        self.base_layers = list(self.base_model.children())

        self.layer0 = nn.Sequential(*self.base_layers[:3]) # size=(N, 64, x.H/2, x.W/2)
        self.layer0_1x1 = convrelu(64, 64, 1, 0)
        self.layer1 = nn.Sequential(*self.base_layers[3:5]) # size=(N, 64, x.H/4, x.W/4)
        self.layer1_1x1 = convrelu(64, 64, 1, 0)
        self.layer2 = self.base_layers[5]  # size=(N, 128, x.H/8, x.W/8)
        self.layer2_1x1 = convrelu(128, 128, 1, 0)
        self.layer3 = self.base_layers[6]  # size=(N, 256, x.H/16, x.W/16)
        self.layer3_1x1 = convrelu(256, 256, 1, 0)
        self.layer4 = self.base_layers[7]  # size=(N, 512, x.H/32, x.W/32)
        self.layer4_1x1 = convrelu(512, 512, 1, 0)

        self.upsample = nn.Upsample(scale_factor=2, mode='bilinear', align_corners=True)

        self.conv_up3 = convrelu(256 + 512, 512, 3, 1)
        self.conv_up2 = convrelu(128 + 512, 256, 3, 1)
        self.conv_up1 = convrelu(64 + 256, 256, 3, 1)
        self.conv_up0 = convrelu(64 + 256, 128, 3, 1)

        self.conv_original_size0 = convrelu(3, 64, 3, 1)
        self.conv_original_size1 = convrelu(64, 64, 3, 1)
        self.conv_original_size2 = convrelu(64 + 128, 64, 3, 1)

        self.conv_last = nn.Conv2d(64, n_class, 1)

    def forward(self, input):
        x_original = self.conv_original_size0(input)
        x_original = self.conv_original_size1(x_original)

        layer0 = self.layer0(input)
        layer1 = self.layer1(layer0)
        layer2 = self.layer2(layer1)
        layer3 = self.layer3(layer2)
        layer4 = self.layer4(layer3)

        layer4 = self.layer4_1x1(layer4)
        x = self.upsample(layer4)
        layer3 = self.layer3_1x1(layer3)
        x = torch.cat([x, layer3], dim=1)
        x = self.conv_up3(x)

        x = self.upsample(x)
        layer2 = self.layer2_1x1(layer2)
        x = torch.cat([x, layer2], dim=1)
        x = self.conv_up2(x)

        x = self.upsample(x)
        layer1 = self.layer1_1x1(layer1)
        x = torch.cat([x, layer1], dim=1)
        x = self.conv_up1(x)

        x = self.upsample(x)
        layer0 = self.layer0_1x1(layer0)
        x = torch.cat([x, layer0], dim=1)
        x = self.conv_up0(x)

        x = self.upsample(x)
        x = torch.cat([x, x_original], dim=1)
        x = self.conv_original_size2(x)

        out = self.conv_last(x)

        return out

# GradCAM Model
class GradCam:
    def __init__(self, model, layers):
        self.model = model
        self.layers = layers
        self.hooks = []
        self.fmap_pool = dict()
        self.grad_pool = dict()

        def forward_hook(module, input, output):
            self.fmap_pool[module] = output.detach().cpu()

        def backward_hook(module, grad_in, grad_out):
            self.grad_pool[module] = grad_out[0].detach().cpu()

        for layer in layers:
            self.hooks.append(layer.register_forward_hook(forward_hook))
            self.hooks.append(layer.register_backward_hook(backward_hook))

    def close(self):
        for hook in self.hooks:
            hook.remove()

    def __enter__(self):
        return self

    def __exit__(self, type, value, traceback):
        self.close()

    def __call__(self, *args, **kwargs):
        self.model.zero_grad()
        return self.model(*args, **kwargs)

    def get(self, layer):
        assert layer in self.layers, f'{layer} not in {self.layers}'
        fmap_b = self.fmap_pool[layer]  # [N, C, fmpH, fmpW]
        grad_b = self.grad_pool[layer]  # [N, C, fmpH, fmpW]

        grad_b = F.adaptive_avg_pool2d(grad_b, (1, 1))  # [N, C, 1, 1]
        gcam_b = (fmap_b * grad_b).sum(dim=1, keepdim=True)  # [N, 1, fmpH, fmpW]
        gcam_b = F.relu(gcam_b)

        return gcam_b


def colorize(tensor, colormap=plt.cm.jet):
    '''Apply colormap to tensor
    Args:
        tensor: (FloatTensor), sized [N, 1, H, W]
        colormap: (plt.cm.*)
    Return:
        tensor: (FloatTensor), sized [N, 3, H, W]
    '''
    tensor = tensor.clamp(min=0.0)
    tensor = tensor.squeeze(dim=1).numpy() # [N, H, W]
    tensor = colormap(tensor)[..., :3] # [N, H, W, 3]
    tensor = torch.from_numpy(tensor).float()
    tensor = tensor.permute(0, 3, 1, 2) # [N, 3, H, W]
    return tensor

def normalize(tensor, eps=1e-8):
    '''Normalize each tensor in mini-batch like Min-Max Scaler
    Args:
        tensor: (FloatTensor), sized [N, C, H, W]
    Return:
        tensor: (FloatTensor) ranged [0, 1], sized [N, C, H, W]
    '''
    N = tensor.size(0)
    min_val = tensor.contiguous().view(N, -1).min(dim=1)[0]
    tensor = tensor - min_val.view(N, 1, 1, 1)
    max_val = tensor.contiguous().view(N, -1).max(dim=1)[0]
    tensor = tensor / (max_val + eps).view(N, 1, 1, 1)
    return tensor

class Model(nn.Module):

    def __init__(self):
        super(Model, self).__init__()
        # Segmentation Model
        self.seg_model = ResNetUNet(n_class=1)
        self.back_alpha = 0.7

        # Classification Model
        self.clf_model = models.densenet121(pretrained=True)
        num_ftrs = self.clf_model.classifier.in_features
        self.clf_model.classifier = nn.Linear(num_ftrs, 7)

        # Transform
        self.input_size = 224
        norm_mean = [0.76304215, 0.5456439, 0.5700431]
        norm_std = [0.14092751, 0.15261441, 0.16997588]

        # Validation & Test Transform
        self.val_transform = transforms.Compose([transforms.Resize((self.input_size, self.input_size)),
                                                 transforms.ToTensor(), transforms.Normalize(norm_mean, norm_std)])
        self.soft = nn.Softmax(dim=1)

    def forward(self, img_path, save_path=None):
        # Open Image -> To Tensor
        X = Image.open(img_path).convert('RGB')
        origin_img = np.array(X.resize((self.input_size, self.input_size)))
        X = self.val_transform(X)
        X = X.unsqueeze(dim=0)

        # Segmentation
        seg_img = self.seg_model(X.reshape(1, 3, self.input_size, self.input_size))
        seg_img = torch.round(torch.sigmoid(seg_img))
        seg_img = torch.cat([seg_img, seg_img, seg_img], dim=1)
        seg_img[seg_img == 0] = self.back_alpha
        X = torch.mul(X, seg_img)

        # Classificcation
        y = self.clf_model(X)
        y_ = self.soft(y).squeeze().detach().numpy()

        # GradCAM
        with GradCam(self.clf_model, [self.clf_model.features]) as gcam:
            out = gcam(X)  # [N, C]
            out[:, torch.argmax(out)].backward()

            gcam_b = gcam.get(self.clf_model.features)  # [N, 1, fmpH, fmpW]
            gcam_b = F.interpolate(gcam_b, [224, 224], mode='bilinear', align_corners=False)  # [N, 1, inpH, inpW]
            gcam_b = colorize(gcam_b).squeeze().permute(1, 2, 0).detach().numpy()

        mixed = gcam_b
        mixed = np.maximum(mixed, 0)
        mixed /= np.max(mixed)
        mixed = np.uint8(255 * mixed)
        mixed = mixed

        result = mixed * 0.5 + origin_img * 0.5
        result = result.astype('uint8')

        # Visualization Result
        # Result Description
        return_list = []
        label_list = ['Actinic keratoses and intraepithelial carcinoma',
                      'Basal cell carcinoma', 'Benign keratosis-like lesions',
                      'Dermatofibroma', 'Melanocytic nevi', 'Vascular lesions', 'Melanoma']

        for i in range(7):
            one_dict = {'Disease': label_list[i], 'Probability': y_[i]}
            return_list.append(one_dict)

        p_list = []
        for r in return_list:
            p_list.append(r['Probability'])

        sort_index = np.argsort(-np.array(p_list))

        # Top 2 Skin Cancer Type
        result_description = '{}: {:.4f}'.format(return_list[sort_index[0]]['Disease'],
                                                 return_list[sort_index[0]]['Probability']) + '\n' + \
                             '{}: {:.4f}'.format(return_list[sort_index[1]]['Disease'],
                                                 return_list[sort_index[1]]['Probability'])

        # Visualization
        fig = plt.figure(figsize=(20, 10))
        ax1 = fig.add_subplot(1, 2, 1)
        ax1.imshow(origin_img)
        ax1.set_title('Original Image')
        ax1.axis("off")

        ax2 = fig.add_subplot(1, 2, 2)
        im2 = ax2.imshow(result, cmap=plt.cm.jet)
        ax2.set_title('Expected degree of skin cancer')
        ax2.axis("off")

        divider = make_axes_locatable(ax2)
        cax = divider.append_axes('right', size='5%', pad=0.05)
        fig.colorbar(im2, cax=cax, orientation='vertical')

        plt.suptitle(result_description, fontsize=20)

        # Save Figure
        if save_path:
            plt.savefig(save_path)
        # plt.show()