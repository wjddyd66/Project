import numpy as np
import librosa
import matplotlib.pyplot as plt
import os
from tqdm import tqdm
import librosa.display
import argparse

# Arg Parse
def parse_args():
    parser = argparse.ArgumentParser(description='COVID Audio Data Augmentation')
    parser.add_argument('--dir_path', help='Model Save Path', default='./dataset/audio/spectrum/train/pos')
    parser.add_argument('--audio_path', help='Audio Dataset Path', default='./dataset/audio/original/pos')

    return parser.parse_args()

def get_spectrogram(wav):
    D = librosa.feature.melspectrogram(y=wav)
    spect, phase = librosa.magphase(D)
    return spect

def manipulate(data, speed_factor):
    return librosa.effects.time_stretch(data, speed_factor)

def pitch_manipulate(data, sampling_rate, pitch_factor):
    return librosa.effects.pitch_shift(data, sampling_rate, pitch_factor)

def time_shift(args, file_list):
    EPS = 1e-8
    for sound in tqdm(file_list, desc='Time Shift.....'):
        fname = os.path.join(args.audio_path, sound[:-3]+'wav')

        duration = librosa.get_duration(filename=fname)

        if duration > 0:
            wav, sr = librosa.load(fname, duration=3.0)
            start_ = int(np.random.uniform(-4800, 4800))

            if start_ >= 0:
                wav_time_shift = np.r_[wav[start_:], np.random.uniform(-0.001, 0.001, start_)]
            else:
                wav_time_shift = np.r_[np.random.uniform(-0.001, 0.001, -start_), wav[:start_]]

            fig = plt.figure(figsize=[4, 4])
            ax = fig.add_subplot(111)
            ax.axes.get_xaxis().set_visible(False)
            ax.axes.get_yaxis().set_visible(False)
            ax.set_frame_on(False)
            log_spect = get_spectrogram(wav_time_shift) + EPS
            librosa.display.specshow(librosa.power_to_db(log_spect, ref=np.max))
            plt.savefig(os.path.join(args.dir_path, sound[:-4] + 'augmented'))
            plt.close(fig)

def time_stretch(args, file_list):
    for sound in tqdm(file_list, desc='Time Stretch.....'):
        fname = os.path.join(args.audio_path, sound[:-3]+'wav')

        duration = librosa.get_duration(filename=fname)

        if duration > 0:
            wav, sr = librosa.load(fname, duration=3.0)
            new_wave = manipulate(wav, speed_factor=2.0)

            fig = plt.figure(figsize=[4, 4])
            ax = fig.add_subplot(111)
            ax.axes.get_xaxis().set_visible(False)
            ax.axes.get_yaxis().set_visible(False)
            ax.set_frame_on(False)
            D = librosa.feature.melspectrogram(y=new_wave, sr=sr)
            librosa.display.specshow(librosa.power_to_db(D, ref=np.max))
            plt.savefig(os.path.join(args.dir_path, sound[:-4] + 'aug_time'))
            plt.close(fig)

def time_low(args, file_list):
    for sound in tqdm(file_list, desc='Time Low.....'):
        fname = os.path.join(args.audio_path, sound[:-3]+'wav')

        duration = librosa.get_duration(filename=fname)

        if duration > 0:
            wav, sr = librosa.load(fname, duration=3.0)
            new_wave = manipulate(wav, speed_factor=0.1)

            fig = plt.figure(figsize=[4, 4])
            ax = fig.add_subplot(111)
            ax.axes.get_xaxis().set_visible(False)
            ax.axes.get_yaxis().set_visible(False)
            ax.set_frame_on(False)
            D = librosa.feature.melspectrogram(y=new_wave, sr=sr)
            librosa.display.specshow(librosa.power_to_db(D, ref=np.max))
            plt.savefig(os.path.join(args.dir_path, sound[:-4] + 'aug_time_low'))
            plt.close(fig)

def pitch(args, file_list):
    for sound in tqdm(file_list, desc='Time Pitch.....'):
        fname = os.path.join(args.audio_path, sound[:-3]+'wav')

        duration = librosa.get_duration(filename=fname)

        if duration > 0:
            wav, sr = librosa.load(fname, duration=3.0)
            new_wave = pitch_manipulate(wav, sampling_rate=sr, pitch_factor=12)

            fig = plt.figure(figsize=[4, 4])
            ax = fig.add_subplot(111)
            ax.axes.get_xaxis().set_visible(False)
            ax.axes.get_yaxis().set_visible(False)
            ax.set_frame_on(False)
            D = librosa.feature.melspectrogram(y=new_wave, sr=sr)
            librosa.display.specshow(librosa.power_to_db(D, ref=np.max))
            plt.savefig(os.path.join(args.dir_path, sound[:-4] + 'aug_pitch'))
            plt.close(fig)

if __name__ == '__main__':
    args = parse_args()
    file_list = os.listdir(args.dir_path)

    time_shift(args, file_list)
    time_stretch(args, file_list)
    time_low(args, file_list)
    pitch(args, file_list)