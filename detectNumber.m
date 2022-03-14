clear;
close all;
clc;

%%% single card numbers
colorImage1 = imread('1.jpg');
I1 = rgb2gray(colorImage1);
detect_number(I1, colorImage1);

colorImage2 = imread('2.jpg');
I2 = rgb2gray(colorImage2);
detect_number(I2, colorImage2);

colorImage3 = imread('3.jpg');
I3 = rgb2gray(colorImage3);
detect_number(I3, colorImage3);

colorImage4 = imread('4.jpg');
I4 = rgb2gray(colorImage4);
detect_number(I4, colorImage4);

colorImage5 = imread('5.jpg');
I5 = rgb2gray(colorImage5);
detect_number(I5, colorImage5);

%%% photoes with a few cards in them
colorImage5 = imread('6.jpg');
I5 = rgb2gray(colorImage5);
detect_number2(I5, colorImage5);

colorImage5 = imread('7.jpg');
I5 = rgb2gray(colorImage5);
detect_number2(I5, colorImage5);

colorImage5 = imread('8.jpg');
I5 = rgb2gray(colorImage5);
detect_number2(I5, colorImage5);

colorImage5 = imread('9.jpg');
I5 = rgb2gray(colorImage5);
detect_number2(I5, colorImage5);
