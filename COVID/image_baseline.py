import Utils
import copy
import torch
import warnings
import argparse
import numpy as np
from tqdm import tqdm
import torch.nn as nn
import torchvision.models as models
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
from sklearn.metrics import roc_auc_score
from torch.optim.lr_scheduler import StepLR
import torch.optim as optim

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='Classification Model BaseLine')
    parser.add_argument('--save_path', help='Model Save Path', default='./model/baseline.pt')
    parser.add_argument('--device', help='Cuda device', type=int, default=0)
    parser.add_argument('--batch_size', help='Batch Size', type=int, default=5)

    return parser.parse_args()

if __name__ == '__main__':
    args = parse_args()
    torch.manual_seed(42)
    device = torch.device("cuda:"+str(args.device) if torch.cuda.is_available() else "cpu")

    # For Classification Dataset
    # Transform
    normalize = transforms.Normalize([0.485, 0.456, 0.406],
                                     [0.229, 0.224, 0.225])

    train_transformer = transforms.Compose([
        transforms.Resize(256),
        transforms.RandomResizedCrop((224), scale=(0.5, 1.0)),
        transforms.RandomHorizontalFlip(),
        transforms.ColorJitter(brightness=0.2, contrast=0.2),
        transforms.ToTensor(),
        normalize
    ])

    val_transformer = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        normalize
    ])

    # Train // Validation // Test Dataset
    trainset = Utils.classification_dataset(root_dir='./dataset/image/classfication/',
                                            txt_COVID='./dataset/image/classfication/Data-split/COVID/trainCT_COVID.txt',
                                            txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/trainCT_NonCOVID.txt',
                                            transform=train_transformer)

    valset = Utils.classification_dataset(root_dir='./dataset/image/classfication/',
                                          txt_COVID='./dataset/image/classfication/Data-split/COVID/valCT_COVID.txt',
                                          txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/valCT_NonCOVID.txt',
                                          transform=val_transformer)

    testset = Utils.classification_dataset(root_dir='./dataset/image/classfication/',
                                           txt_COVID='./dataset/image/classfication/Data-split/COVID/testCT_COVID.txt',
                                           txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/testCT_NonCOVID.txt',
                                           transform=val_transformer)

    # Batch Data Loader
    train_loader = DataLoader(trainset, batch_size=args.batch_size, drop_last=False, shuffle=True)
    val_loader = DataLoader(valset, batch_size=args.batch_size, drop_last=False, shuffle=False)
    test_loader = DataLoader(testset, batch_size=args.batch_size, drop_last=False, shuffle=False)

    # PreTrain Model: Densenet169
    model = models.densenet169(pretrained=True).to(device)
    pretrained_net = torch.load('./model/pretrain/classification/Self-Trans.pt', map_location=device)
    model.load_state_dict(pretrained_net)

    # Change output Num of Class
    model.classifier = nn.Sequential(nn.Linear(1664, 2), nn.Softmax(dim=1)).to(device)

    # Model Train & Validation
    early_stopping = Utils.EarlyStopping(patience=10, delta=0)
    valid_losses = []
    best_loss = np.Inf

    # train
    bs = args.batch_size
    votenum = 1

    warnings.filterwarnings('ignore')

    optimizer = optim.Adam(model.parameters(), lr=1e-5)
    scheduler = optim.lr_scheduler.CosineAnnealingLR(optimizer, T_max=10)

    scheduler = StepLR(optimizer, step_size=1)

    total_epoch = 100
    for epoch in tqdm(range(total_epoch), desc='Epoch...'):
        vote_pred = np.zeros(valset.__len__())
        vote_score = np.zeros(valset.__len__())

        Utils.classification_train(optimizer, model, train_loader, device)

        targetlist, scorelist, predlist, epoch_loss = Utils.ckassification_val(model, val_loader, device)
        vote_pred = vote_pred + predlist
        vote_score = vote_score + scorelist
        AtrainUC = roc_auc_score(targetlist, vote_score)


        # major vote
        vote_pred[vote_pred <= (votenum / 2)] = 0
        vote_pred[vote_pred > (votenum / 2)] = 1
        vote_score = vote_score / votenum

        print('vote_pred', vote_pred)
        print('targetlist', targetlist)
        TP = ((vote_pred == 1) & (targetlist == 1)).sum()
        TN = ((vote_pred == 0) & (targetlist == 0)).sum()
        FN = ((vote_pred == 0) & (targetlist == 1)).sum()
        FP = ((vote_pred == 1) & (targetlist == 0)).sum()

        print('TP=', TP, 'TN=', TN, 'FN=', FN, 'FP=', FP)
        print('TP+FP', TP + FP)
        p = TP / (TP + FP)
        print('precision', p)
        p = TP / (TP + FP)
        r = TP / (TP + FN)
        print('recall', r)
        F1 = 2 * r * p / (r + p)
        acc = (TP + TN) / (TP + TN + FP + FN)
        print('F1', F1)
        print('acc', acc)
        print('AUC: ', AtrainUC)

        # For Early Stopping
        valid_losses.append(epoch_loss.item())
        valid_loss = np.average(valid_losses)
        early_stopping(valid_loss)

        # Best Model Candidate
        if epoch_loss < best_loss:
            best_model_sd = copy.deepcopy(model.state_dict())
            best_loss = epoch_loss

        if early_stopping.early_stop:
            print('Early Stopping')
            print('Epoch [{}/{}],  Dev AUC: {:.4f}'.format((epoch + 1), total_epoch, epoch_loss.item()))
            break

    model.load_state_dict(best_model_sd)
    # Save Model
    torch.save(model.state_dict(), args.save_path)

    # Test
    print('\n\n\n\nTest.........................')
    model = models.densenet169(pretrained=True).to(device)
    # Change output Num of Class
    model.classifier = nn.Sequential(nn.Linear(1664, 2), nn.Softmax(dim=1)).to(device)
    # Load Model
    model.load_state_dict(torch.load(args.save_path, map_location=device))

    bs = args.batch_size
    warnings.filterwarnings('ignore')

    vote_pred = np.zeros(testset.__len__())
    vote_score = np.zeros(testset.__len__())

    targetlist, scorelist, predlist = Utils.ckassification_test(model, test_loader, device)
    print('target', targetlist)
    print('score', scorelist)
    print('predict', predlist)
    vote_pred = vote_pred + predlist
    vote_score = vote_score + scorelist

    TP = ((predlist == 1) & (targetlist == 1)).sum()

    TN = ((predlist == 0) & (targetlist == 0)).sum()
    FN = ((predlist == 0) & (targetlist == 1)).sum()
    FP = ((predlist == 1) & (targetlist == 0)).sum()

    print('TP=', TP, 'TN=', TN, 'FN=', FN, 'FP=', FP)
    print('TP+FP', TP + FP)
    p = TP / (TP + FP)
    print('precision', p)
    p = TP / (TP + FP)
    r = TP / (TP + FN)
    print('recall', r)
    F1 = 2 * r * p / (r + p)
    acc = (TP + TN) / (TP + TN + FP + FN)
    print('F1', F1)
    print('acc', acc)
    AUC = roc_auc_score(targetlist, vote_score)
    print('AUC', AUC)

    with open('./result/baseline.txt', 'w') as file:
        line = 'TP='+str(TP)+'TN='+str(TN)+'FN='+str(FN)+'FP='+str(FP)+'\n'
        file.write(line)
        line = 'Precision: '+str(p)+' Recall: '+str(r)+' F1: '+str(F1)+' ACC: '+str(acc)+' AUC: '+str(AUC)+'\n'
        file.write(line)