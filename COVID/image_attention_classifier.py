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
import torch.optim as optim

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='Classification Model BaseLine')
    parser.add_argument('--device', help='Cuda device', type=int, default=0)
    parser.add_argument('--batch_size', help='Batch Size', type=int, default=5)
    parser.add_argument('--lateral_map', help='Lateral Map', type=int, default=1)
    parser.add_argument('--min_set', help='Min Set', type=float, default=0.1)
    parser.add_argument('--grid_search', help='if 1: Grid Search, else: Test', type=int, default=1)

    return parser.parse_args()

# For Train
def model_train(args, model):
    torch.manual_seed(42)
    device = torch.device("cuda:"+str(args.device) if torch.cuda.is_available() else "cpu")

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

    # Dataset Load
    # Train // Validation // Test DataLoader
    trainset = Utils.classification_mask_dataset(classification_dir='./dataset/image/classfication/',
                                           segmentation_dir='./dataset/image/classfication/Segmentation/',
                                           txt_COVID='./dataset/image/classfication/Data-split/COVID/trainCT_COVID.txt',
                                           txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/trainCT_NonCOVID.txt',
                                           transform=train_transformer,
                                           lateral_map=args.lateral_map, min_seg=args.min_set)

    valset = Utils.classification_mask_dataset(classification_dir='./dataset/image/classfication/',
                                         segmentation_dir='./dataset/image/classfication/Segmentation/',
                                         txt_COVID='./dataset/image/classfication/Data-split/COVID/valCT_COVID.txt',
                                         txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/valCT_NonCOVID.txt',
                                         transform=val_transformer,
                                         lateral_map=args.lateral_map, min_seg=args.min_set)

    # Batch Data Loader
    mask_train_loader = DataLoader(trainset, batch_size=args.batch_size, drop_last=False, shuffle=True)
    mask_val_loader = DataLoader(valset, batch_size=args.batch_size, drop_last=False, shuffle=False)

    # Hyper Parameter Setting => For Early Stopping
    early_stopping = Utils.EarlyStopping(patience=10, delta=0)
    valid_losses = []
    best_loss = np.Inf

    # train
    votenum = 1
    warnings.filterwarnings('ignore')
    optimizer = optim.Adam(model.parameters(), lr=1e-5)

    total_epoch = 100
    for epoch in tqdm(range(total_epoch), desc='Epoch...'):
        vote_pred = np.zeros(valset.__len__())
        vote_score = np.zeros(valset.__len__())

        Utils.classification_train(optimizer, model, mask_train_loader, device)

        targetlist, scorelist, predlist, epoch_loss = Utils.ckassification_val(model, mask_val_loader, device)
        vote_pred = vote_pred + predlist
        vote_score = vote_score + scorelist

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
        AtrainUC = roc_auc_score(targetlist, vote_score)
        print('AUC: ', AtrainUC)

        # For Early Stopping
        valid_losses.append(epoch_loss.item())
        valid_loss = np.average(valid_losses)
        early_stopping(valid_loss)

        # Best Model Candidate
        if epoch_loss < best_loss:
            best_model_sd = copy.deepcopy(model.state_dict())
            best_loss = epoch_loss
            with open('./result/GridSearch.txt', 'a') as file:
                line = 'Validation' + '\n'
                file.write(line)
                line = 'TP=' + str(TP) + 'TN=' + str(TN) + 'FN=' + str(FN) + 'FP=' + str(FP) + '\n'
                file.write(line)
                line = 'Precision: ' + str(p) + ' Recall: ' + str(r) + ' F1: ' + str(F1) + ' ACC: ' + str(
                    acc) + ' AUC: ' + str(AtrainUC) + '\n'
                file.write(line)


        if early_stopping.early_stop:
            print('Early Stopping')
            print('Epoch [{}/{}],  Dev AUC: {:.4f}'.format((epoch + 1), total_epoch, epoch_loss.item()))

            break

    model.load_state_dict(best_model_sd)

    return model

def model_test(args, model):
    device = torch.device("cuda:" + str(args.device) if torch.cuda.is_available() else "cpu")

    # Transform
    normalize = transforms.Normalize([0.485, 0.456, 0.406],
                                     [0.229, 0.224, 0.225])

    val_transformer = transforms.Compose([
        transforms.Resize((224, 224)),
        transforms.ToTensor(),
        normalize
    ])

    # Test
    print('\n\n\n\nTest.........................')
    testset = Utils.classification_mask_dataset(classification_dir='./dataset/image/classfication/',
                                                segmentation_dir='./dataset/image/classfication/Segmentation/',
                                                txt_COVID='./dataset/image/classfication/Data-split/COVID/testCT_COVID.txt',
                                                txt_NonCOVID='./dataset/image/classfication/Data-split/NonCOVID/testCT_NonCOVID.txt',
                                                transform=val_transformer,
                                                lateral_map=args.lateral_map, min_seg=args.min_set)
    mask_test_loader = DataLoader(testset, batch_size=args.batch_size, drop_last=False, shuffle=False)

    warnings.filterwarnings('ignore')
    vote_score = np.zeros(testset.__len__())

    targetlist, scorelist, predlist = Utils.ckassification_test(model, mask_test_loader, device)
    print('target', targetlist)
    print('score', scorelist)
    print('predict', predlist)
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

    with open('./result/GridSearch.txt', 'a') as file:
        line = 'Test'+'\n'
        file.write(line)
        line = 'TP=' + str(TP) + 'TN=' + str(TN) + 'FN=' + str(FN) + 'FP=' + str(FP) + '\n'
        file.write(line)
        line = 'Precision: ' + str(p) + ' Recall: ' + str(r) + ' F1: ' + str(F1) + ' ACC: ' + str(acc) + ' AUC: ' + str(
            AUC) + '\n'
        file.write(line)

def grid_search(args):
    device = torch.device("cuda:" + str(args.device) if torch.cuda.is_available() else "cpu")

    # Grid Search
    lateral_list = np.arange(1, 5, 1)
    min_set = np.arange(0.1, 1, 0.1)

    for l in lateral_list:
        for m in min_set:
            # Load PreTrain Model
            model = models.densenet169(pretrained=True).to(device)
            pretrained_net = torch.load('./model/pretrain/classification/Self-Trans.pt', map_location=device)
            model.load_state_dict(pretrained_net)

            # Change output Num of Class
            # model.classifier = nn.Linear(1664, 2).to(device)
            model.classifier = nn.Sequential(nn.Linear(1664, 2), nn.Softmax(dim=1)).to(device)

            # Hyperparameter
            args.lateral_map = l
            args.min_set = m

            # Save Log
            with open('./result/GridSearch.txt', 'a') as file:
                line = '\n\nlateral: ' + str(args.lateral_map) + ' min_seg: ' + str(args.min_set) + '\n'
                file.write(line)

            # Train Model
            model = model_train(args, model)

            # Save Model
            torch.save(model.state_dict(), './model/' + str(args.lateral_map) + '_' + str(args.min_set) + '.pt')

            # Test
            model_test(args, model)

if __name__ == '__main__':
    args = parse_args()

    if bool(args.grid_search) == True:
        grid_search(args)

    else:
        print('Test...')
        device = torch.device("cuda:" + str(args.device) if torch.cuda.is_available() else "cpu")
        # Result of Grid Search
        args.lateral_map = 3
        args.min_set = 0.8

        # Load PreTrain Model
        model = models.densenet169(pretrained=True)
        # pretrained_net = torch.load('./model/pretrain/classification/Self-Trans.pt')
        # model.load_state_dict(pretrained_net)

        # Change output Num of Class
        # model.classifier = nn.Linear(1664, 2).to(device)
        model.classifier = nn.Sequential(nn.Linear(1664, 2), nn.Softmax(dim=1))
        model.load_state_dict(torch.load('./model/single_modality/3_0.8.pt', map_location='cpu'))
        model.to(device)
        # Test
        model_test(args, model)