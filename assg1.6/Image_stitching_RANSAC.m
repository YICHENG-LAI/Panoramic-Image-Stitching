%% This code is to stitch the images using the best homography
function res5 = Image_stitching_RANSAC(im1,im2)
%% get inliers (best matches)
image11 = im1;
image22 = im2;
image1=imread(image11);
image2=imread(image22);
inliers = RANSAC_find_inliers(image11,image22);

%% get homography matrix
x1 = inliers(:,1);
y1 = inliers(:,2);
x2 = inliers(:,3);
y2 = inliers(:,4);
n = length(inliers);
H = get_Homography(x1,y1,x2,y2,n);

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
res3 = imtranslate(image1,[-min(offset.x,0),-min(offset.y,0)], 'OutputView', 'full');

%% concatenate the images
figure(2);
res4 = my_imfuse(res2,res3);
% clear the dark part
im_x = sum(res4,[2,3]);
im_y = sum(res4,[1,3]);
new_x = find(im_x > 0);
new_y = find(im_y > 0);
res5 = res4(new_x(1):new_x(end),new_y(1):new_y(end),:);
imshow(res5);
end