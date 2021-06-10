import librosa
import librosa.display
import matplotlib.pyplot as plt
import numpy as np
import os
from tqdm import tqdm
import argparse
import Utils
import random
import shutil

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='Wav to Spectrum')
    parser.add_argument('--dir_path', help='WAV Data Path', default='./dataset/audio/original/')
    parser.add_argument('--save_path', help='Spectrum Data Save Path', default='./dataset/audio/spectrum/')

    return parser.parse_args()

def wav_spectrum(args):
    # Make Save Directory
    Utils.createFolder(os.path.join(args.save_path, 'neg'))
    Utils.createFolder(os.path.join(args.save_path, 'pos'))

    files = [os.path.join(args.dir_path, "neg"), os.path.join(args.dir_path, "pos")]

    for file in files:
        path = file
        file_list = os.listdir(path)

        for sound in tqdm(file_list, desc='Wav to Spectrum...'):
            fname = os.path.join(file, sound)
            duration = librosa.get_duration(filename=fname)

            if duration>0:
                samples, sample_rate = librosa.load(fname, duration=3.0)

                fig = plt.figure(figsize=[4,4])
                ax = fig.add_subplot(111)
                ax.axes.get_xaxis().set_visible(False)
                ax.axes.get_yaxis().set_visible(False)
                ax.set_frame_on(False)
                S = librosa.feature.melspectrogram(y=samples, sr=sample_rate)
                librosa.display.specshow(librosa.power_to_db(S, ref=np.max))
                plt.savefig(os.path.join(args.save_path, file[-3:], sound[:-4]))
                plt.close(fig)

def split_train_val_test(args):
    # File List
    pos_lists = os.listdir(os.path.join(args.save_path, 'pos'))
    neg_lists = os.listdir(os.path.join(args.save_path, 'neg'))

    # Validation Dataset
    pos_val = random.sample(pos_lists, 30)
    for p_v in pos_val:
        Utils.createFolder(os.path.join(args.save_path, 'val', 'pos'))
        old_dir = os.path.join(args.save_path, 'pos', p_v)
        new_dir = os.path.join(args.save_path, 'val', 'pos', p_v)
        shutil.copy(old_dir, new_dir)
        pos_lists.remove(p_v)

    neg_val = random.sample(neg_lists, 30)
    for n_v in neg_val:
        Utils.createFolder(os.path.join(args.save_path, 'val', 'neg'))
        old_dir = os.path.join(args.save_path, 'neg', n_v)
        new_dir = os.path.join(args.save_path, 'val', 'neg', n_v)
        shutil.copy(old_dir, new_dir)
        neg_lists.remove(n_v)

    # Test Dataset
    pos_test = random.sample(pos_lists, 30)
    for p_t in pos_test:
        Utils.createFolder(os.path.join(args.save_path, 'test', 'pos'))
        old_dir = os.path.join(args.save_path, 'pos', p_t)
        new_dir = os.path.join(args.save_path, 'test', 'pos', p_t)
        shutil.copy(old_dir, new_dir)
        pos_lists.remove(p_t)

    neg_test = random.sample(neg_lists, 30)
    for n_t in neg_test:
        Utils.createFolder(os.path.join(args.save_path, 'test', 'neg'))
        old_dir = os.path.join(args.save_path, 'neg', n_t)
        new_dir = os.path.join(args.save_path, 'test', 'neg', n_t)
        shutil.copy(old_dir, new_dir)
        neg_lists.remove(n_t)

    # Train Dataset
    for p in pos_lists:
        Utils.createFolder(os.path.join(args.save_path, 'train', 'pos'))
        old_dir = os.path.join(args.save_path, 'pos', p)
        new_dir = os.path.join(args.save_path, 'train', 'pos', p)
        shutil.copy(old_dir, new_dir)

    for n in neg_lists:
        Utils.createFolder(os.path.join(args.save_path, 'train', 'neg'))
        old_dir = os.path.join(args.save_path, 'neg', n)
        new_dir = os.path.join(args.save_path, 'train', 'neg', n)
        shutil.copy(old_dir, new_dir)

    # Remove Original Spectrum Data
    shutil.rmtree(os.path.join(args.save_path, 'pos'))
    shutil.rmtree(os.path.join(args.save_path, 'neg'))

if __name__ == '__main__':
    # Fix Seed
    random.seed(42)
    args = parse_args()
    # Wav to Spectrum
    wav_spectrum(args)
    # Train/ Val/ Test
    split_train_val_test(args)