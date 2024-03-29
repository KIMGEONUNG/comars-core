#!/usr/bin/env python3

import argparse 
import os
import numpy as np
from os.path import join
from random import shuffle
from cv2 import cv2 as cv
from torchvision.utils import make_grid
from torchvision.transforms import ToPILImage
from PIL import Image
from tqdm import tqdm
import torch
import matplotlib.pyplot as plt


config = \
{
'gt':{'ext': 'jpg'},
'gray':{'ext': 'jpg'},
'chromagan':{'ext': 'jpg'},
'instcolor':{'ext': 'png'},
'cic':{'ext': 'jpg'},
'cic_sig':{'ext': 'jpg'},
'deoldify':{'ext': 'jpg'},
'ours':{'ext': 'jpg'},
}

def parse():
    parser = argparse.ArgumentParser()
    parser.add_argument('--mode', type=str, default='sequential',
            choices=['random', 'sequential', 'specify'])
    parser.add_argument('--target_ids', type=str, nargs='+', default=None)
    parser.add_argument('--targets', type=str, nargs='+',
            default=[
                    'gt',
                    'gray',
                    'chromagan',
                    'instcolor',
                    'cic',
                    'cic_sig',
                    'deoldify',
                    ])
    parser.add_argument('--caption_id', action='store_false')
    parser.add_argument('--caption_type', action='store_false')
    parser.add_argument('--only_one', action='store_true')
    parser.add_argument('--resolution', type=int, default=256) 
    parser.add_argument('--length', type=int, default=10) 
    parser.add_argument('--path_out', type=str, default='out')
    return parser.parse_args()


def cv2torch(x):
    x = x / 255
    x = np.flip(x, -1).copy()
    x = torch.Tensor(x).permute(0,3,1,2)
    return x

def main(args):
    ids = ['%05d' % i for i in range(50000)]
    num_iter = int(len(ids) / args.length)
    if args.mode == 'sequential':
        pass
    elif args.mode == 'random':
        shuffle(ids)
    elif args.mode == 'specify':
        ids = args.target_ids
        if ids is None:
            raise Exception('No targets are specified')

        args.length = len(ids)
        num_iter = 1
    else:
        raise Exception('Invalid mode')

    for i in tqdm(range(num_iter)):
        id_group = ids[i * args.length: (i + 1) * args.length]

        paths = []
        for target in args.targets:
            for id in id_group:
                path = join(target, id + '.' + config[target]['ext'])
                paths.append(path)
        
        # imgs = [cv.imread(path) for path in paths]
        imgs = [cv.resize(cv.imread(path), (args.resolution, args.resolution))
            for path in paths]

        imgs = [np.expand_dims(img, 0) for img in imgs]
        imgs = np.vstack(imgs)
        imgs = cv2torch(imgs)
        grid = make_grid(imgs, nrow=args.length)


        fontFace = cv.FONT_HERSHEY_SIMPLEX
        fontscale = 1.2 
        color = (0, 0, 0) 
        # cv.putText(im, args.caption, org, fontFace, fontscale , color,
        #         thickness=args.thickness)
        if args.caption_id:
            buff = 80 
            _, _, length = grid.shape
            unit = int(length / len(id_group)) 
            paper = np.ones((buff, length, 3)) * 255
            for j in range(len(id_group)):
                cv.putText(paper, str(id_group[j]), (unit * j + 50, buff // 2),
                           fontFace, fontscale, color, thickness=2)

            paper = paper / 255
            paper = np.flip(paper, -1).copy()
            paper = torch.Tensor(paper).permute(2,0,1)
            grid = torch.cat([grid, paper], 1)
        if args.caption_type:
            buff = 310 
            _, length, _ = grid.shape

            unit = int(length / len(args.targets)) 
            paper = np.ones((length, buff, 3)) * 255
            for j in range(len(args.targets)):
                cv.putText(paper, str(args.targets[j]), (10, unit * j + 130),
                           fontFace, fontscale, color, thickness=2)

            paper = paper / 255
            paper = np.flip(paper, -1).copy()
            paper = torch.Tensor(paper).permute(2,0,1)
            grid = torch.cat([paper, grid], 2)


        grid = ToPILImage()(grid)
        # grid.show()
        grid.save(join(args.path_out, '%05d.jpg' % i))
        if args.only_one:
            exit()

if __name__ == '__main__':
    args = parse()
    main(args)
