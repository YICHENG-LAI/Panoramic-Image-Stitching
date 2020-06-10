%% This code is to sticth images manually

%% read images
image1=imread('im01.jpg');
image2=imread('im02.jpg');

%% set n points(n >= 4)
n = 4;
imshow(image1);
title('Click 4 points');
[x1,y1] = ginput(n);
close all;
imshow(image2); 
title('Click 4 points');
[x2,y2] = ginput(n);
close all;

%% get homography matrix from im02 to im01
H = get_Homography(x2,y2,x1,y1,n);

%% transform image
t = projective2d(H);
res = imwarp(image2,t);
                
%% get the offsets of the images and translate
%get image size
sizeI1 = size(image1);
sizeI2 = size(image2);
sizeI3 = size(res);
%compute corner location after tansforming
corner1 = H' * [0;0;1];
corner2 = H' * [sizeI2(2);0;1];
corner3 = H' * [0;sizeI2(1);1];
corner4 = H' * [sizeI2(2);sizeI2(1);1];
corner1 = corner1/corner1(3);
corner2 = corner2/corner2(3);
corner3 = corner3/corner3(3);
corner4 = corner4/corner4(3);
x3 = [corner1(1);corner2(1);corner3(1);corner4(1)];
y3 = [corner1(2);corner2(2);corner3(2);corner4(2)];
%compute offset
offset.x = min(x3);
offset.y = min(y3);
%translate based on offset
res2 = imtranslate(res,[offset.x,offset.y], 'OutputView', 'full');
res3 = imtranslate(image1,[min(offset.x,0),-min(offset.y,0)], 'OutputView', 'full');

%% concatenate the images
figure(1);
res4 = my_imfuse(res2,res3);
imshow(res4);