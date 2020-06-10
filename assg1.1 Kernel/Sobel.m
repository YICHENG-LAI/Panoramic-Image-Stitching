%% sobel convolution function
function covimg = Sobel(imatrix,kernel_size)
  %sobel kernel
  sobelx = [-1 -2 -1;0 0 0;1 2 1];
  sobely = [-1 0 1;-2 0 2;-1 0 1];
  %set the scale of sobel kernel
  newsobelx = set_scale(sobelx,kernel_size);
  newsobely = set_scale(sobely,kernel_size);
  %compute the horizontal and vertical direction convolution
  convx = conv2d(imatrix,newsobelx);
  convy = conv2d(imatrix,newsobely);
  covimg = sqrt(convx.^2 + convy.^2);
end