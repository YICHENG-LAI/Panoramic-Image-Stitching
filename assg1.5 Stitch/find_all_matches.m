%% This function is to find all the matches
function all_matches = find_all_matches(im1_descriptors, im1_locs,im2_descriptors, im2_locs)

%% get descriptors
%     image: the file name for the image (grayscale)
%     locs: matrix in which each row gives a keypoint location (row,
%           column, scale, orientation)
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints. The descriptor is a vector
%         of 128 values normalized to unit length.
im1_points = length(im1_locs(:,1));
im2_points = length(im2_locs(:,1));
tag = 0; % im1_points > im2_points
% consider the key points of im1 are less than im2 - start
% exchange im1 and im2 
if im1_points < im2_points
   tag = 1;% im1_points < im2_points
   tmpt1 = im1_descriptors;
   im1_descriptors = im2_descriptors;
   im2_descriptors = tmpt1;
   tmpt2 = im1_locs;
   im1_locs = im2_locs;
   im2_locs = tmpt2;
end
im1_points = length(im1_locs(:,1));
im2_points = length(im2_locs(:,1));

%% find all matches
distance = zeros(im1_points,im2_points);
min_points = min(im1_points,im2_points);
for i = 1:im1_points
    for j = 1:im2_points
        des_tmp = (im1_descriptors(i,:) - im2_descriptors(j,:)).^2;
        distance(i,j) = sum(sqrt(des_tmp));
    end
end
matches = zeros(im1_points,1);
for i = 1:im2_points
        matches(i) = find(distance(:,i)==min(distance(:,i)));
end
all_matches = [1 matches(1)];
for i = 2:min_points
    if ~ismember(matches(i),all_matches(:,2))
       all_matches = [all_matches;i matches(i)];
    else
        j = find(all_matches(:,2) == matches(i));
        if distance(matches(i),i) < distance(matches(i),all_matches(j,1))
            all_matches(j,1) = i;
        end
    end
end
% consider the key points of im1 are less than im2 - end
if tag == 1
    all_matches = fliplr(all_matches);
end
end
