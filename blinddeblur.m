clc;
clear;
close all;

%http://www.mathworks.cn/cn/help/images/examples/deblurring-images-using-the-blind-deconvolution-algorithm.html

%read an image
gI = imread('lena_std.tif');
I = rgb2gray(gI);
figure;imshow(I);title('original');

%simulate a blur
PSF = fspecial('gaussian',7,10);
Blurred = imfilter(I,PSF,'symmetric','conv');
figure;imshow(Blurred);title('Blurred');

%restore the image using various PSF
underPSF = ones(size(PSF)-4);
[J1,P1] = deconvblind(Blurred,underPSF);
%figure;imshow(J1);title('undersized psf');

overPSF = padarray(underPSF,[4,4],'replica','both');
[J2,P2] = deconvblind(Blurred,overPSF);
%figure;imshow(J2);title('oversized psf');

initPSF = padarray(underPSF,[2,2],'replica','both');
[J3,P3] = deconvblind(Blurred,initPSF);
%figure;imshow(J3);title('initsized psf');

%analysiz returned PSFs
% figure;
% subplot(221);imshow(PSF,[],'InitialMagnification','fit');
% title('True PSF');
% subplot(222);imshow(P1,[],'InitialMagnification','fit');
% title('Reconstructed Undersized PSF');
% subplot(223);imshow(P2,[],'InitialMagnification','fit');
% title('Reconstructed Oversized PSF');
% subplot(224);imshow(P3,[],'InitialMagnification','fit');
% title('Reconstructed true PSF');

%Improving the Restoration
weight = edge(I,'sobel');
se = strel('disk',2);
WEIGHT = 1-double(imdilate(weight,se));
WEIGHT([1:3 end-(0:2)],:) = 0;
WEIGHT(:,[1:3 end-(0:2)]) = 0;
figure;imshow(WEIGHT);title('Weight array');
[J, P] = deconvblind(Blurred,initPSF,30,[],WEIGHT);
figure;imshow(J);title('Deblurred Image');