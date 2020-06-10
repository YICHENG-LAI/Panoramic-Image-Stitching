%% This code is to show all the matches of the two images based on SIFT

%% read images
image1=imread('im01.jpg');
image2=imread('im02.jpg');
im1_size = size(image1);
im2_size = size(image2);

%% get descriptors
%     image: the file name for the image (grayscale)
%     locs: matrix in which each row gives a keypoint location (row,
%           column, scale, orientation)
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints. The descriptor is a vector
%         of 128 values normalized to unit length.
[im1, im1_descriptors, im1_locs] = sift('im01.jpg');
[im2, im2_descriptors, im2_locs] = sift('im02.jpg');

%% find all matches
all_matches = find_all_matches(im1_descriptors, im1_locs,im2_descriptors, im2_locs);

%% show two images in the same figure
W = im1_size(2) + im2_size(2);
H = max(im1_size(1),im2_size(1));
newimg = zeros(H,W,3);
newimg(1:im1_size(1),1:im1_size(2),:) = image1;
newimg(1:im2_size(1),im1_size(2)+1:end,:) = image2;
newimg = newimg / max(max(max(newimg)));
figure(1);
imshow(newimg);

%% show all the matches
right_matches = all_matches(:,1);%image2
left_matches = all_matches(:,2);%image1
hold on;
for i = 1:length(all_matches)
    line([im1_locs(left_matches(i),2),im2_locs(right_matches(i),2)+im1_size(2)],...
    [im1_locs(left_matches(i),1),im2_locs(right_matches(i),1)],'color',[rand,rand,rand],'LineWidth',1)
end
hold off;
