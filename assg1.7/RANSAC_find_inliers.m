%% This code is to find Best Homography by RANSAC
function [inliers,ismatch] = RANSAC_find_inliers(image11,image22)
%% read images 
image1=imread(image11);
image2=imread(image22);
im1_size = size(image1);
im2_size = size(image2);

%% get descriptors
%     image: the file name for the image (grayscale)
%     locs: matrix in which each row gives a keypoint location (row,
%           column, scale, orientation)
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints. The descriptor is a vector
%         of 128 values normalized to unit length.
[~, im1_descriptors, im1_locs] = sift(image11);
[~, im2_descriptors, im2_locs] = sift(image22);

%% find all matches
%all_matches-[im2,im1];;;;;x1,y1(im2);;;;;;x2,y2(im1)
all_matches = find_all_matches(im1_descriptors, im1_locs,im2_descriptors, im2_locs);
len_all_matches = length(all_matches);
x1_all_matches = zeros(len_all_matches,1);
x2_all_matches = zeros(len_all_matches,1);
y1_all_matches = zeros(len_all_matches,1);
y2_all_matches = zeros(len_all_matches,1);
for i = 1:len_all_matches
    x1_all_matches(i) = [im2_locs(all_matches(i,1),2)];
    y1_all_matches(i) = [im2_locs(all_matches(i,1),1)];
    x2_all_matches(i) = [im1_locs(all_matches(i,2),2)];
    y2_all_matches(i) = [im1_locs(all_matches(i,2),1)];
end

%% ---------------------------RANSAC-------------------------------

%% select n pairs of keypoints randomly (n >= 5)
n = 5;
inliers = [];
for m = 1:3000
rand_index = randperm(length(all_matches));
out_index = rand_index(1:n);
rand_matches = [];
for i = 1:n
    rand_matches = [rand_matches;all_matches(out_index(i),:)];
end
x1 = zeros(n,1);
x2 = zeros(n,1);
y1 = zeros(n,1);
y2 = zeros(n,1);
for i = 1:n
    x2(i) = [im1_locs(rand_matches(i,2),2)];
    y2(i) = [im1_locs(rand_matches(i,2),1)];
    x1(i) = [im2_locs(rand_matches(i,1),2)];
    y1(i) = [im2_locs(rand_matches(i,1),1)];
end

%% get homography matrix
H = get_Homography(x1,y1,x2,y2,n);

%% compute inliers
% compute distance d(xi',Hxi)
distance = zeros(len_all_matches,1);
    tmp_inliers = [];
for i = 1:len_all_matches
     d_tmp = H' * [x1_all_matches(i);y1_all_matches(i);1];
     d_tmp = d_tmp/d_tmp(3);
     dif = ([x2_all_matches(i);y2_all_matches(i);1] - d_tmp).^2;
     distance(i) = sqrt(sum(dif));
     % create tmp_inliers
     if distance(i) < 5
         tmp_inliers = [tmp_inliers;x1_all_matches(i) y1_all_matches(i) ...
             x2_all_matches(i) y2_all_matches(i)];
     end
end
% update inliers
if length(tmp_inliers) > length(inliers)
    inliers = tmp_inliers;
end
end

%% show the matches (support the best homography)
% plot two images in the same figure
Width = im1_size(2) + im2_size(2);
Height = max(im1_size(1),im2_size(1));
newimg = zeros(Height,Width,3);
newimg(1:im1_size(1),1:im1_size(2),:) = image1;
newimg(1:im2_size(1),im1_size(2)+1:end,:) = image2;
newimg = newimg / max(max(max(newimg)));
figure(1);
imshow(newimg);
% plot inliers
hold on;
for i = 1:length(inliers)
    line([inliers(i,3),inliers(i,1)+im1_size(2)],...
    [inliers(i,4),inliers(i,2)],'color',[rand,rand,rand],'LineWidth',1)
end
hold off;
title('Inliers-Best matches')
ismatch = 0;
if length(inliers) > 0.1 * length(all_matches)
    ismatch = 1;
end
end