clc;clear;close all;
img = imread('lena_std.tif');
img = rgb2gray(img);
img_mean = mean2(img);
img_std = std2(img);
imhist(img);
title(['mean:',num2str(img_mean),' std:',num2str(img_std)]);
figure,imshow(img);
