%% This code is to stitch more images linearly using the best homography

%% read images
images =["im01.jpg";"im02.jpg";"im03.jpg";"im04.jpg";"im05.jpg"]; 
samples = length(images);

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