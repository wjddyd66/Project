import torch
import torchvision
import torch.nn as nn
from torchvision import transforms
import torchvision.models as models
import torch.optim as optim

from torch.utils.data import DataLoader, WeightedRandomSampler
from tqdm import tqdm
import numpy as np
import os
import copy
import argparse
import Utils

# Audio Classification Model
class Audio_classification(nn.Module):
    def __init__(self):
        super(Audio_classification, self).__init__()

        self.layer1 = nn.Sequential(
            nn.MaxPool2d(2, 2),  # 200x200
            nn.Conv2d(3, 6, 5, stride=1, padding=2),
            nn.ReLU(),
            nn.MaxPool2d(2, 2)
        )

        self.layer2 = nn.Sequential(
            nn.Conv2d(6, 12, 5, stride=1, padding=2),
            nn.ReLU(),
            nn.MaxPool2d(2, 2)
        )

        self.layer3 = nn.Sequential(
            nn.Conv2d(12, 24, 5, stride=1, padding=2),
            nn.ReLU(),
            nn.MaxPool2d(2, 2)
        )

        self.layer4 = nn.Sequential(
            nn.Conv2d(24, 48, 5, stride=1, padding=2),
            nn.ReLU(),
            nn.MaxPool2d(2, 2)
        )

        self.fc_layer = nn.Sequential(
            nn.Flatten(),
            nn.Linear(48 * 12 * 12, 100),
            nn.ReLU(),
            nn.Linear(100, 2),
            nn.Softmax(dim=1)
        )

    def forward(self, x):
        x = self.layer1(x)
        x = self.layer2(x)
        x = self.layer3(x)
        x = self.layer4(x)
        x = self.fc_layer(x)

        return x

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='Audio Model')
    parser.add_argument('--save_path', help='Model Save Path', default='./model/audio.pt')
    parser.add_argument('--device', help='Cuda device', type=int, default=0)
    parser.add_argument('--batchsize', help='Batch Size', type=int, default=5)

    return parser.parse_args()

def evaluate(model, test_loader):
    model.eval()
    test_loss = 0
    correct = 0
    criterion = nn.CrossEntropyLoss()

    with torch.no_grad():
        for data, target in test_loader:
            data, target = data.to(device), target.to(device)
            output = model(data)
            # 배치 오차를 합산
            test_loss += criterion(output, target.squeeze())

            # 가장 높은 값을 가진 인덱스가 바로 예측값
            correct += torch.sum(torch.argmax(output, 1) == target.squeeze()).item()

    test_loss /= len(test_loader.dataset)
    test_accuracy = 100. * correct / len(test_loader.dataset)
    return test_loss, test_accuracy

if __name__ == '__main__':
    args = parse_args()
    torch.manual_seed(42)
    device = torch.device("cuda:"+str(args.device) if torch.cuda.is_available() else "cpu")

    num_epochs = 50

    # Normalization
    normalize = transforms.Normalize([0.5600, 0.4616, 0.5346],
                                     [0.4453, 0.4573, 0.4147])

    trans = transforms.Compose([
        transforms.ToTensor(),
        normalize
    ])

    # For Dataset
    train_set = torchvision.datasets.ImageFolder(root='./Coswara-Data-spectrum/train', transform=trans)
    val_set = torchvision.datasets.ImageFolder(root='./Coswara-Data-spectrum/validation', transform=trans)
    test_set = torchvision.datasets.ImageFolder(root='./Coswara-Data-spectrum/test', transform=trans)

    print('Num of Train', len(train_set))
    print('Num of Test', len(test_set))

    # For OverSampling
    num_neg = len(os.listdir('./Coswara-Data-spectrum/train/neg/'))
    num_pos = len(os.listdir('./Coswara-Data-spectrum/train/pos/'))

    np_neg = np.zeros(num_neg)
    np_pos = np.ones(num_pos)
    targets = np.hstack((np_neg, np_pos))

    class_count = np.unique(targets, return_counts=True)[1]
    weight = 1. / torch.tensor(class_count, dtype=torch.float)
    class_weights_all = weight[targets]
    sampler = WeightedRandomSampler(class_weights_all, len(targets), replacement=True)

    train_loader = DataLoader(dataset=train_set, batch_size=args.batchsize, sampler=sampler, drop_last=True)
    val_loader = DataLoader(dataset=val_set, batch_size=args.batchsize, drop_last=True)
    test_loader = DataLoader(dataset=test_set, batch_size=args.batchsize, drop_last=True)

    # Check Oversampling
    neg_count = 0
    pos_count = 1
    for d in train_loader:
        for dd in d[1]:
            if dd == 0:
                neg_count += 1
            else:
                pos_count += 1

    print('Result of Oversampling...')
    print('Train Neg Count: ', neg_count)
    print('Train Pos Count: ', pos_count)

    model = Audio_classification().to(device)

    # Model Train & Validation
    early_stopping = Utils.EarlyStopping(patience=10, delta=0)
    valid_losses = []
    best_loss = np.Inf
    best_model_sd = None

    criterion = nn.CrossEntropyLoss()
    optimizer = optim.Adam(model.parameters(), lr=1e-4, weight_decay=1e-4)

    for epoch in tqdm(range(num_epochs), desc='Epoch...'):  # 데이터셋을 수차례 반복합니다.
        train_loss = 0
        # Train
        model.train()

        correct = 0
        for iteration, data in tqdm(enumerate(train_loader), desc='Iteration...'):
            # [inputs, labels]의 목록인 data로부터 입력을 받은 후;
            inputs, labels = data
            inputs, labels = inputs.to(device), labels.to(device)

            # 변화도(Gradient) 매개변수를 0으로 만들고
            optimizer.zero_grad()

            # 순전파 + 역전파 + 최적화를 한 후
            outputs = model(inputs)
            # print(outputs)
            # print(labels)
            # print('\n\nShape....')
            # print(outputs.shape)
            # print(labels.shape)
            loss = criterion(outputs, labels.squeeze())

            train_loss += loss
            loss.backward()
            optimizer.step()
            if iteration % 100 == 0:
                print('Iteration [{}/{}] Train Loss: {:.4f}'.format(iteration, len(train_loader),
                                                                    train_loss / (iteration + 1)))
            # For Sigmoid Output
            correct += torch.sum(torch.argmax(outputs, 1) == labels.squeeze()).item()

        train_accuracy = 100. * correct / len(train_loader.dataset)

        # Evaluate
        train_loss = train_loss / len(train_loader.dataset)
        epoch_loss, valid_accuracy = evaluate(model, val_loader)
        _, test_accuracy = evaluate(model, test_loader)
        print('\nEpoch [{}/{}] Train Loss: {:.4f} Train Accuracy:: {:.2f} Validation Loss: {:.4f}, Validation Accuracy: {:.2f}%\n'
              .format(epoch, num_epochs, train_loss, train_accuracy, epoch_loss, valid_accuracy))

        print('Test Accuracy: {:.2f}%\n'.format(test_accuracy))

        # Best Model Candidate
        if epoch_loss < best_loss:
            best_model_sd = copy.deepcopy(model.state_dict())
            best_loss = epoch_loss

        if early_stopping.early_stop:
            print('Early Stopping')
            print('Epoch [{}/{}],  Dev AUC: {:.4f}'.format((epoch + 1), num_epochs, epoch_loss.item()))
            break

    model.load_state_dict(best_model_sd)
    # Save Model
    torch.save(model.state_dict(), args.save_path)

    print('\n\nTest..........')
    test_set = torchvision.datasets.ImageFolder(root='./dataset/audio/spectrum/test', transform=trans)
    test_loader = DataLoader(dataset=test_set, batch_size=args.batchsize, drop_last=False)

    # Load PreTrain Model
    model = Audio_classification().to(device)
    model.load_state_dict(torch.load("./model/audio.pt", map_location=device))
    _, test_accuracy = evaluate(model, test_loader)
    print('Test Accuracy: {:.2f}%\n'.format(test_accuracy))
