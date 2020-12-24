import os
import shutil
import argparse
import pandas as pd
from tqdm import tqdm
import Utils

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='Audio Data Select')
    parser.add_argument('--dir_path', help='Audio Original Data Path', default='./dataset/audio/Coswara-Data/')
    parser.add_argument('--save_path', help='Audio Data Save Path', default='./dataset/audio/original/')

    return parser.parse_args()

def audio_select(args):
    # Make Save Directory
    Utils.createFolder(os.path.join(args.save_path, 'neg'))
    Utils.createFolder(os.path.join(args.save_path, 'pos'))

    path = args.dir_path
    save_path = args.save_path

    data_file = pd.read_csv(path+'/combined_data.csv')

    covid_data = pd.DataFrame([data_file['id'],data_file['covid_status']])
    covid_data = covid_data.T

    # Positive Sample
    positive_id = list(covid_data[covid_data['covid_status'].str.startswith('positive')]['id'])
    # print('Positive Sample: ', positive_id)

    # Negative Sample
    negative_id = list(covid_data[~(covid_data['covid_status'].str.startswith('positive'))]['id'])
    # print('Negative Sample: ', negative_id)

    # Each File Data
    file_lists = os.listdir(path)

    # Delete .label, .git ....
    for f in file_lists:
        if '.' in f:
            file_lists.remove(f)


    # File Path
    for file_list in tqdm(file_lists,desc='File Select...'):
        file_name = os.path.join(path, file_list)
        pos = list(set(positive_id).intersection(os.listdir(file_name)))
        neg = list(set(negative_id).intersection(os.listdir(file_name)))

        print('Num of pos: ', len(pos))
        print('Num of neg: ', len(neg))

        for pos_list in pos:
            old_pos_dir_heavy = os.path.join(file_name,pos_list,'cough-heavy.wav')
            old_pos_dir_shallow = os.path.join(file_name, pos_list, 'cough-shallow.wav')
            new_dir_pos_heavy = os.path.join(save_path,'pos','cough-heavy'+pos_list+'.wav')
            new_dir_pos_shallow = os.path.join(save_path, 'pos','cough-shallow'+pos_list+'.wav')
            shutil.copy(old_pos_dir_heavy,new_dir_pos_heavy)
            if pos_list == '9hftEYixyhP1Neeq3fB7ZwITQC53':
                continue
            shutil.copy(old_pos_dir_shallow, new_dir_pos_shallow)

        for neg_list in neg:
            old_neg_dir_heavy = os.path.join(file_name,neg_list,'cough-heavy.wav')
            old_neg_dir_shallow = os.path.join(file_name, neg_list, 'cough-shallow.wav')
            new_dir_neg_heavy = os.path.join(save_path,'neg','cough-heavy'+neg_list+'.wav')
            new_dir_neg_shallow = os.path.join(save_path, 'neg','cough-shallow'+neg_list+'.wav')
            shutil.copy(old_neg_dir_heavy,new_dir_neg_heavy)
            if neg_list == '9hftEYixyhP1Neeq3fB7ZwITQC53':
                continue
            shutil.copy(old_neg_dir_shallow, new_dir_neg_shallow)

    neg_list_num = os.listdir(os.path.join(save_path, 'neg'))
    pos_list_num = os.listdir(os.path.join(save_path, 'pos'))

    print('After Select Num of Pos: ', len(pos_list_num))
    print('After Select Num of Neg: ', len(neg_list_num))

if __name__ == '__main__':
    args = parse_args()
    audio_select(args)