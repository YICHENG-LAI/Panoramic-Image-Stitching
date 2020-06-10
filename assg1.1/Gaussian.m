%Gaussian convolution function
function covimg = Gaussian(imatrix,kernel_size)
  %Gaussian kernel
  Gaussian = 1/16*[1 2 1;2 4 2;1 2 1];
  %set the scale of Gaussian kernel
  newGaussian = set_scale(Gaussian,kernel_size);
  %compute convolution
  covimg = conv2d(imatrix,newGaussian);
end