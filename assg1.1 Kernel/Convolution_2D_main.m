%% This code is to show the results of convolution image using kernels
%----------------------parameters that can be set-------------------------------------------
%kernel_size and the kernel convolution function can be set at the first
%and third part of the code

%% 1 set kernel_size
kernel_size = 1;

%% 2 read image and convert to gray level image
image1=imread('im.jpg');
imatrix=rgb2gray(image1);

%% 3 compute the convolution image matrix 
%could change the function as 'Gaussian','Sobel'
%covimg = Sobel(imatrix,kernel_size);

%if do Haarlike 
%convolution,Haarkernel could be'Haar12''Haar21''Haar13''Haar31''Haar22'

Haarkernel = 'Haar12';
covimg = Haarlike(imatrix,kernel_size,Haarkernel);

%% 4 normalization
newimg = covimg/max(max(covimg));

%% 5 plot the image after convolution
figure(1);
imshow(imatrix);
figure(2);
imshow(newimg);