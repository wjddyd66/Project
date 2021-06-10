import os
from PIL import Image
from PIL import ImageOps
from scipy import misc
from tqdm import tqdm
import torch
import torchvision.transforms as transforms

# PreTrain InfNet Model
from InfNet_Res2Net import Inf_Net

# For Segmentation Dataset
class segmentation_dataset:
    def __init__(self, image_root, testsize):
        self.testsize = testsize
        self.images = [image_root + f for f in os.listdir(image_root) if f.endswith('.jpg') or f.endswith('.png')]
        self.images = sorted(self.images)
        self.transform = transforms.Compose([
            transforms.Resize((self.testsize, self.testsize)),
            transforms.ToTensor(),
            transforms.Normalize([0.485, 0.456, 0.406],
                                 [0.229, 0.224, 0.225])])
        # self.gt_transform = transforms.ToTensor()
        self.size = len(self.images)
        self.index = 0

    def load_data(self):
        image = self.rgb_loader(self.images[self.index])
        # ori_size = image.size
        image = self.transform(image).unsqueeze(0)
        # gt = self.binary_loader(self.gts[self.index])
        name = self.images[self.index].split('/')[-1]
        if name.endswith('.jpg'):
            name = name.split('.jpg')[0] + '.png'
        self.index += 1

        return image, name

    def rgb_loader(self, path):
        with open(path, 'rb') as f:
            img = Image.open(f)
            rotate = img.rotate(90, expand=True)
            # img = ImageOps.flip(rotate)
            return rotate.convert('RGB')

if __name__ == '__main__':
    # Fix Seed
    torch.manual_seed(42)
    device = torch.device("cuda:4" if torch.cuda.is_available() else "cpu")
    print('Device: ', device)

    # Output Size
    target_size = 352

    # Load PreTrain InfNet Model
    model = Inf_Net(device).to(device)
    model.load_state_dict(torch.load('./model/pretrain/segmentation/Semi-Inf-Net-100.pth', map_location=device))

    # Predict Segmentation
    model.eval()
    covid_image_root = './dataset/image/classfication/CT_COVID/'
    non_covid_image_root = './dataset/image/classfication/CT_NonCOVID/'
    target_size = 352

    ## For COVID
    # DataLoader
    covid_loader = segmentation_dataset(covid_image_root, target_size)

    # Save Segmentation Result
    for i in tqdm(range(covid_loader.size), desc='Covid Segmentation....'):
        image, name = covid_loader.load_data()

        image = image.to(device)
        lateral_map_5, lateral_map_4, lateral_map_3, lateral_map_2, lateral_edge = model(image)
        reses = [lateral_edge, lateral_map_2, lateral_map_3, lateral_map_4, lateral_map_5]

        for num_class, res_ in enumerate(reses):
            save_path = './dataset/image/classfication/Segmentation/CT_COVID/'
            res = res_.sigmoid().data.cpu().numpy().squeeze()
            # res = (res - res.min()) / (res.max() - res.min() + 1e-8)

            if num_class == 0:
                save_path = os.path.join(save_path, 'edge')
            else:
                save_path = os.path.join(save_path, 'lateral_map' + str(5-num_class))

            try:
                if not (os.path.isdir(save_path)):
                    os.makedirs(save_path)
                file_path = os.path.join(save_path, name)

            except Exception as e:
                print('Exception: ', e)
                pass

            misc.imsave(file_path, res)

    ## For Non COVID
    # DataLoader
    non_covid_loader = segmentation_dataset(non_covid_image_root, target_size)

    # Save Segmentation Result
    for i in tqdm(range(non_covid_loader.size), desc='NonCovid Segmentation...'):
        image, name = non_covid_loader.load_data()

        image = image.to(device)
        lateral_map_5, lateral_map_4, lateral_map_3, lateral_map_2, lateral_edge = model(image)
        reses = [lateral_edge, lateral_map_2, lateral_map_3, lateral_map_4, lateral_map_5]

        for num_class, res_ in enumerate(reses):
            save_path = './dataset/image/classfication/Segmentation/CT_NonCOVID/'
            res = res_.sigmoid().data.cpu().numpy().squeeze()
            # res = (res - res.min()) / (res.max() - res.min() + 1e-8)

            if num_class == 0:
                save_path = os.path.join(save_path, 'edge')
            else:
                save_path = os.path.join(save_path, 'lateral_map' + str(5-num_class))

            try:
                if not (os.path.isdir(save_path)):
                    os.makedirs(save_path)
                file_path = os.path.join(save_path, name)

            except:
                print('Exception: ', e)
                pass

            misc.imsave(file_path, res)