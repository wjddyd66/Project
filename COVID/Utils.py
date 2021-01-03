import os
import numpy as np
from PIL import Image
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import Dataset
import torchvision.transforms as transforms
from tqdm import tqdm

# Segmentation Dataset
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
            return img.convert('RGB')

# Mean of Segmentation Result
def chek_mean_of_segmentation(lateral_map=1):
    image_root = os.path.join('./dataset/classfication/Segmentation/CT_COVID/lateral_map' + str(lateral_map) + '/')
    lateral_map_images = [image_root + f for f in os.listdir(image_root) if f.endswith('.jpg') or f.endswith('.png')]
    result = []
    for l in lateral_map_images:
        img = Image.open(l)
        result.append(np.mean(img))

    print("COVID: ", np.mean(result))

    image_root = os.path.join('./dataset/classfication/Segmentation/CT_NonCOVID/lateral_map' + str(lateral_map) + '/')
    lateral_map_images = [image_root + f for f in os.listdir(image_root) if f.endswith('.jpg') or f.endswith('.png')]
    result = []
    for l in lateral_map_images:
        img = Image.open(l)
        result.append(np.mean(img))

    print("Non-COVID: ", np.mean(result))

# Classification Dataset
def read_txt(txt_path):
    with open(txt_path) as f:
        lines = f.readlines()
    txt_data = [line.strip() for line in lines]
    return txt_data

# Classsification Datasetclassification_train
class classification_dataset(Dataset):
    def __init__(self, root_dir, txt_COVID, txt_NonCOVID, transform=None):
        self.root_dir = root_dir
        self.txt_path = [txt_COVID, txt_NonCOVID]
        self.classes = ['CT_COVID', 'CT_NonCOVID']
        self.num_cls = len(self.classes)
        self.img_list = []
        for c in range(self.num_cls):
            cls_list = [[os.path.join(self.root_dir, self.classes[c], item), c] for item in read_txt(self.txt_path[c])]
            self.img_list += cls_list
        self.transform = transform

    def __len__(self):
        return len(self.img_list)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()

        img_path = self.img_list[idx][0]
        image = Image.open(img_path).convert('RGB')

        if self.transform:
            image = self.transform(image)
        sample = {'img': image,
                  'label': int(self.img_list[idx][1])}
        return sample

# Classification With mask
class classification_mask_dataset(Dataset):
    def __init__(self, classification_dir, segmentation_dir, txt_COVID, txt_NonCOVID, transform=None, lateral_map=1,
                 min_seg=0.01):
        self.classification_dir = classification_dir
        self.segmentation_dir = segmentation_dir

        self.txt_path = [txt_COVID, txt_NonCOVID]
        self.classes = ['CT_COVID', 'CT_NonCOVID']
        self.num_cls = len(self.classes)

        self.img_list = []
        self.segment_list = []
        self.min_seg = min_seg

        for c in range(self.num_cls):
            # Classification List
            cls_list = [[os.path.join(self.classification_dir, self.classes[c], item), c] for item in
                        read_txt(self.txt_path[c])]
            self.img_list += cls_list
            # Segmentation List
            seg_list = [[os.path.join(self.segmentation_dir, self.classes[c], "lateral_map" + str(lateral_map),
                                      item.replace('.jpg', '.png')), c] for item in read_txt(self.txt_path[c])]
            self.segment_list += seg_list

        self.transform = transform

    def __len__(self):
        return len(self.img_list)

    def __getitem__(self, idx):
        if torch.is_tensor(idx):
            idx = idx.tolist()

        # Original Data
        img_path = self.img_list[idx][0]
        image = Image.open(img_path).convert('RGB')
        image = image.resize((256, 256))

        # Segmentation Data
        seg_path = self.segment_list[idx][0]
        seg = Image.open(seg_path).convert('RGB')
        seg = seg.rotate(-90, expand=True)
        seg = seg.resize((256, 256))

        # Mask with Original Data
        # Step 1 => Segmentation Min-Max Normalization + Min Value(Hyperparameter)
        seg_np = np.array(seg)
        seg_mask = (seg_np - seg_np.min()) / (seg_np.max() - seg_np.min()) + self.min_seg
        # Clip max = 1
        seg_mask = np.clip(seg_mask, 0, 1)

        # Step 2 => Original Data with seg_mask
        image_with_mask = np.multiply(image, seg_mask)

        # Step 3 => Change Numpy Dtype => For Using Image Preprocessing
        image_with_mask = Image.fromarray(np.uint8(image_with_mask))

        if self.transform:
            image_with_mask = self.transform(image_with_mask)
            # image = self.transform(image)

        sample = {'img': image_with_mask,
                  'label': int(self.img_list[idx][1])}
        return sample

# Fir model Train
def classification_train(optimizer, model, train_loader, device):
    model.train()

    train_loss = 0
    train_correct = 0

    for batch_index, batch_samples in enumerate(train_loader):
        # move data to device
        data, target = batch_samples['img'].to(device), batch_samples['label'].to(device)
        optimizer.zero_grad()
        output = model(data)
        criteria = nn.CrossEntropyLoss()
        loss = criteria(output, target.long())
        train_loss += criteria(output, target.long())

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        pred = output.argmax(dim=1, keepdim=True)
        train_correct += pred.eq(target.long().view_as(pred)).sum().item()

# For model Validation
def ckassification_val(model, val_loader, device):
    model.eval()
    test_loss = 0
    correct = 0

    criteria = nn.CrossEntropyLoss()
    # Don't update model
    with torch.no_grad():
        predlist = []
        scorelist = []
        targetlist = []
        # Predict
        for batch_index, batch_samples in enumerate(val_loader):
            data, target = batch_samples['img'].to(device), batch_samples['label'].to(device)
            output = model(data)

            test_loss += criteria(output, target.long())
            score = F.softmax(output, dim=1)
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.long().view_as(pred)).sum().item()
            targetcpu = target.long().cpu().numpy()
            predlist = np.append(predlist, pred.cpu().numpy())
            scorelist = np.append(scorelist, score.cpu().numpy()[:, 1])
            targetlist = np.append(targetlist, targetcpu)

    return targetlist, scorelist, predlist, test_loss

# For Model Test
def ckassification_test(model, test_loader, device):
    model.eval()
    test_loss = 0
    correct = 0

    criteria = nn.CrossEntropyLoss()
    # Don't update model
    with torch.no_grad():
        predlist = []
        scorelist = []
        targetlist = []
        # Predict
        for batch_index, batch_samples in enumerate(test_loader):
            data, target = batch_samples['img'].to(device), batch_samples['label'].to(device)
            output = model(data)

            test_loss += criteria(output, target.long())
            score = F.softmax(output, dim=1)
            print(output)
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.long().view_as(pred)).sum().item()
            targetcpu = target.long().cpu().numpy()
            predlist = np.append(predlist, pred.cpu().numpy())
            scorelist = np.append(scorelist, score.cpu().numpy()[:, 1])
            targetlist = np.append(targetlist, targetcpu)

    return targetlist, scorelist, predlist

# Early Stopping
class EarlyStopping:
    """Early stops the training if validation loss doesn't improve after a given patience."""
    def __init__(self, patience=10, delta=0):
        """
        Args:
            patience (int): How long to wait after last time validation loss improved.
                            Default: 100
            verbose (bool): If True, prints a message for each validation loss improvement.
                            Default: False
            delta (float): Minimum change in the monitored quantity to qualify as an improvement.
                            Default: 0
        """
        self.patience = patience
        self.counter = 0
        self.best_score = None
        self.early_stop = False
        self.val_loss_min = np.Inf
        self.delta = delta

    def __call__(self, val_loss):
        score = -val_loss

        if self.best_score is None:
            self.best_score = score

        elif score < self.best_score + self.delta:
            self.counter += 1
            if self.counter >= self.patience:
                self.early_stop = True
        else:
            self.best_score = score
            self.counter = 0

# Create Directory
def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)

##### Multi Modal
# Fir model Train
def Late_Fusion_train(optimizer, model, train_loader, device):
    model.train()

    train_loss = 0
    train_correct = 0

    for batch_index, batch_samples in tqdm(enumerate(train_loader), desc='Iteration...'):
        # move data to device
        image, audio, target = batch_samples['img'].to(device), batch_samples['audio'].to(device), batch_samples['label'].to(device)
        optimizer.zero_grad()
        output = model(image, audio)
        criteria = nn.CrossEntropyLoss()
        loss = criteria(output, target.long())
        train_loss += criteria(output, target.long())

        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        pred = output.argmax(dim=1, keepdim=True)
        train_correct += pred.eq(target.long().view_as(pred)).sum().item()

# For model Validation
def Late_Fusion_val(model, val_loader, device):
    model.eval()
    test_loss = 0
    correct = 0

    criteria = nn.CrossEntropyLoss()
    # Don't update model
    with torch.no_grad():
        predlist = []
        scorelist = []
        targetlist = []
        # Predict
        for batch_index, batch_samples in enumerate(val_loader):
            image, audio, target = batch_samples['img'].to(device), batch_samples['audio'].to(device), batch_samples[
                'label'].to(device)
            output = model(image, audio)

            test_loss += criteria(output, target.long())
            score = F.softmax(output, dim=1)
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.long().view_as(pred)).sum().item()
            targetcpu = target.long().cpu().numpy()
            predlist = np.append(predlist, pred.cpu().numpy())
            scorelist = np.append(scorelist, score.cpu().numpy()[:, 1])
            targetlist = np.append(targetlist, targetcpu)

    return targetlist, scorelist, predlist, test_loss

# For Model Test
def Late_Fusion_test(model, test_loader, device):
    model.eval()
    test_loss = 0
    correct = 0

    criteria = nn.CrossEntropyLoss()
    # Don't update model
    with torch.no_grad():
        predlist = []
        scorelist = []
        targetlist = []
        # Predict
        for batch_index, batch_samples in enumerate(test_loader):
            image, audio, target = batch_samples['img'].to(device), batch_samples['audio'].to(device), batch_samples[
                'label'].to(device)
            output = model(image, audio)

            test_loss += criteria(output, target.long())
            # score = F.softmax(output, dim=1)
            score = output
            print('Output...')
            print(output)
            print('Target...')
            print(target)
            pred = output.argmax(dim=1, keepdim=True)
            correct += pred.eq(target.long().view_as(pred)).sum().item()
            targetcpu = target.long().cpu().numpy()
            predlist = np.append(predlist, pred.cpu().numpy())
            scorelist = np.append(scorelist, score.cpu().numpy()[:, 1])
            targetlist = np.append(targetlist, targetcpu)

    return targetlist, scorelist, predlist
