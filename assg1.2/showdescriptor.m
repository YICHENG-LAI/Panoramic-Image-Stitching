%% showdescriptor(image, locs, descriptors)
%
% This function displays an image with SIFT keypoints overlayed.
%   Input parameters:
%     image: the file name for the image (grayscale)
%     locs: matrix in which each row gives a keypoint location (row,
%           column, scale, orientation)
%     descriptors: a K-by-128 matrix, where each row gives an invariant
%         descriptor for one of the K keypoints.  The descriptor is a vector
%         of 128 values normalized to unit length.

function showdescriptor(image, locs, descriptors)

disp('Drawing SIFT descriptors ...');

%Draw image with keypoints
figure(1);
imshow(image);
hold on;
imsize = size(image);
%Draw some the descriptors so that the image looks clearer
for i = 1: size(locs,1)/10
    %draw 4*4 grid at each keypoint
    for j = 0:4
        TransformLine(imsize, locs(i,:),-2.0, -2.0+j, 2.0, -2.0+j);
        TransformLine(imsize, locs(i,:),-2.0+j, -2.0, -2.0+j, 2.0);
    end
    %draw 128(4*4*8) vectors of each descriptor and each grid contains 8 vectors
    for j = 1:4
        for k = 1:4
            l = [1,2,3,4,5,6,7,8];
            TransformLine1(descriptors(i,:), j, k, l(1), locs(i,:),-1.5+j-1, 1.5-k+1, -1.0+j-1, 1.5-k+1);
            TransformLine1(descriptors(i,:), j, k, l(2), locs(i,:),-1.5+j-1, 1.5-k+1, -1.0+j-1, 2.0-k+1);
            TransformLine1(descriptors(i,:), j, k, l(3), locs(i,:),-1.5+j-1, 1.5-k+1, -1.5+j-1, 2.0-k+1);
            TransformLine1(descriptors(i,:), j, k, l(4), locs(i,:),-1.5+j-1, 1.5-k+1, -2.0+j-1, 2.0-k+1);
            TransformLine1(descriptors(i,:), j, k, l(5), locs(i,:),-1.5+j-1, 1.5-k+1, -2.0+j-1, 1.5-k+1);
            TransformLine1(descriptors(i,:), j, k, l(6), locs(i,:),-1.5+j-1, 1.5-k+1, -2.0+j-1, 1.0-k+1);
            TransformLine1(descriptors(i,:), j, k, l(7), locs(i,:),-1.5+j-1, 1.5-k+1, -1.5+j-1, 1.0-k+1);
            TransformLine1(descriptors(i,:), j, k, l(8), locs(i,:),-1.5+j-1, 1.5-k+1, -1.0+j-1, 1.0-k+1);
        end
    end
end
hold off;
end


%% ------ Subroutine: TransformLine -------
% Draw the given line in the image, but first translate, rotate, and
% scale according to the keypoint parameters.
%
% Parameters:
%   Arrays:
%    imsize = [rows columns] of image
%    keypoint = [subpixel_row subpixel_column scale orientation]
%
%   Scalars:
%    x1, y1; begining of vector
%    x2, y2; ending of vector
function TransformLine(imsize, keypoint, x1, y1, x2, y2)

% The scaling of the unit length arrow is set to approximately the radius
%   of the region used to compute the keypoint descriptor.
len = 1 * keypoint(3);

% Rotate the keypoints by 'ori' = keypoint(4)
s = sin(keypoint(4));
c = cos(keypoint(4));

% Apply transform
r1 = keypoint(1) - len * (c * y1 + s * x1);
c1 = keypoint(2) + len * (- s * y1 + c * x1);
r2 = keypoint(1) - len * (c * y2 + s * x2);
c2 = keypoint(2) + len * (- s * y2 + c * x2);

line([c1 c2], [r1 r2], 'Color', 'red');
end

%% ------ Subroutine: TransformLine1 for descriptors -------
% Draw the given line in the image, but first translate, rotate, and
% scale according to the keypoint parameters.
%
% Parameters:
%   Arrays:
%    descriptor = [vectorof 128 values normalized to unit length]
%    keypoint = [subpixel_row subpixel_column scale orientation]
%
%   Integer:
%     i(1:4), j(1:4), k(1:8): the location of values in the 128-vector descriptor for each
%     arrow in the 4*4 grid
%
%   Scalars:
%    x1, y1; begining of vector
%    x2, y2; ending of vector
function TransformLine1(descriptor, j, k, l, keypoint, x1, y1, x2, y2)

% The scaling of the unit length arrow is set to approximately the radius
%   of the region used to compute the keypoint descriptor.
len = 1 * keypoint(3) * 1;

% Rotate the keypoints by 'ori' = keypoint(4)
s = sin(keypoint(4));
c = cos(keypoint(4));

% Apply transform
r1 = keypoint(1) - len * (c * y1 + s * x1);
c1 = keypoint(2) + len * (- s * y1 + c * x1);
r2 = keypoint(1) - len * (c * y2 + s * x2);
c2 = keypoint(2) + len * (- s * y2 + c * x2);
c22 = c1 + 3 * descriptor(((j-1)*4+(k-1))*8+l) * (c2-c1);
r22 = r1 + 3 * descriptor(((j-1)*4+(k-1))*8+l) * (r2-r1);
line([c1 c22], [r1 r22], 'Color', 'yellow');
end
