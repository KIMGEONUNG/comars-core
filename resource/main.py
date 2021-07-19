import argparse
import regex
import numpy as np
import matplotlib.pyplot as plt
from skimage.io import imread, imshow
from skimage.color import rgb2gray

def parsearg():
    parse = argparse.ArgumentParser(
            description="Visualize frequency domain from image")
    parse.add_argument('input_files', nargs='+', help='input file paths')
    parse.add_argument('--postfix', default='fft-',
            help='postfix using in output file name')
    parse.add_argument('--show', default=False, action='store_true',
            help='show image without save')

    return parse.parse_args()

def main():
    args = parsearg() 
    for f in args.input_files:
        dark_image = imread(f)
        dark_image_grey = rgb2gray(dark_image)
        fourier_spectrum = np.fft.fft2(dark_image_grey)
        fourier_spectrum_shifted = np.fft.fftshift(fourier_spectrum)

        fig, ax = plt.subplots(1, 2, figsize=(10, 5), dpi=150)

        i = 0
        ax[i].set_title('Gray Image')
        ax[i].imshow(dark_image_grey, cmap='gray')
        ax[i].axis('off')

        i = 1
        ax[i].set_title('Fourier Transformation')
        ax[i].imshow(np.log(abs(fourier_spectrum_shifted)), cmap='gray');
        ax[i].axis('off')


        if args.show:
            plt.show()
        else:
            target_dir = ''
            filename = ''
            target = target_dir + '/' + args.postfix + 'filename'
            print(f)
            print(target_dir)
            print(filename)
            print(target)
            # plt.savefig(target)

if __name__ == '__main__':
    main()
