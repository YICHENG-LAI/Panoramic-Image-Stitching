%% This code is to compute the homography matrix and transform the images

%% read images
image1=imread('h1.jpg');
image2=imread('h2.jpg');

%% set n points(n >= 4)
n = 4;
imshow(image1);
[x1,y1] = ginput(n);
close all;
imshow(image2);
[x2,y2] = ginput(n);                                                                                                                            

%% compute homography
A = [];
for i = 1:n
    A = [A;x1(i) y1(i) 1 0 0 0 -x1(i)*x2(i) -x2(i)*y1(i) -x2(i);
          0 0 0 x1(i) y1(i) 1 -x1(i)*y2(i) -y2(i)*y1(i) -y2(i)];
end
[U,D,V] = svd(A);
H = V(:,end);
H = reshape(H,[3,3]);
%H = H/H(3,3);
inv_H = inv(H);

%% Image transform
t1 = projective2d(H);
t2 = projective2d(inv_H);
res1 = imwarp(image1,t1);
res2 = imwarp(image2,t2);
tmpt = H' * [x1(1);y1(1);1];
tmpt = tmpt/tmpt(3);
figure(1);
imshow(res1);
figure(2);
imshow(res2);