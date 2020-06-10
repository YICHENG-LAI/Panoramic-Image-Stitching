%% This code is to stitch all the 5 images
% read images
images =["im01.jpg";"im02.jpg";"im03.jpg";"im04.jpg";"im05.jpg"]; 

%% stitch im02 and im03 to t1
t1 = Image_stitching_RANSAC(images(3),images(2));
imwrite(t1,'t1.jpg');
%% stitch im03 and im04 to t2
t2 = Image_stitching_RANSAC(images(3),images(4));
imwrite(t2,'t2.jpg');
%% stitch im01,t1(im02 and im03) to t3
t3 = Image_stitching_RANSAC('t1.jpg',images(1));
imwrite(t3,'t3.jpg');
%% stitch im05,t2(im03 and im04) to t4
t4 = Image_stitching_RANSAC('t2.jpg',images(5));
imwrite(t4,'t4.jpg');
%% stich t3 and t4
t5 = Image_stitching_RANSAC('t3.jpg','t4.jpg');
imwrite(t5,'t5.jpg');