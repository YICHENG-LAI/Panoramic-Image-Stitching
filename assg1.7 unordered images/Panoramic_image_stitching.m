%% This code is to stitch unordered images using the best homography
   
%% read images
input_images =["M1.jpg";"M2.jpg";"M3.jpg";"M4.jpg";"M5.jpg"];
samples = length(input_images);
% make it unordered
unordered_images = [input_images(2),input_images(3),input_images(5),input_images(1),input_images(4)];
% sort the images
images = Sort_images(unordered_images);


%% stitch images
% split the images into 2 calss by the image at the center
% find the image at teh center
m = round(samples/ 2);
if mod(samples,2) == 1
    i = m - 1;
    j = m + 1;
    res1 = images(m);
    res2 = images(m);
    imwrite(imread(res1),'res1.jpg');
    imwrite(imread(res2),'res2.jpg');
else
    i = m;
    j = m + 1;
    res1 = images(i);
    res2 = iamges(j);
    imwrite(res1,'res1.jpg');
    imwrite(res2,'res2.jpg');
end
% stitch the first half 
while i > 0
    if i == m
        i = i - 1;
        continue
    end
    res1 = Image_stitching_RANSAC('res1.jpg',images(i));
    imwrite(res1,'res1.jpg');
    i = i - 1;
end
% stitch the last half
while j <= samples
    if mod(samples,2) == 0
        j = j + 1;
        continue
    end
    res2 = Image_stitching_RANSAC('res2.jpg',images(j));
    imwrite(res2,'res2.jpg');
    j = j + 1;
end
% stitch two calss images
res3 = Image_stitching_RANSAC('res1.jpg','res2.jpg');
imwrite(res3,'res3.jpg');  