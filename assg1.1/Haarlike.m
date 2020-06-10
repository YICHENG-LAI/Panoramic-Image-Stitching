%% Haar-like kernel convolution function
function covimg = Haarlike(imatrix,kernel_size,Haarkernel)
  %choose the Haarlike kernel
  Haar12 = [-1 1];
  Haar21 = Haar12';
  Haar13 = [-1 1 -1];
  Haar31 = Haar13';
  Haar22 = [1 -1;-1 1];
  %set the scale of Haar-like kernel
  newHaarkernel = set_scale(Haarkernel,kernel_size);
  %compute convolution
  covimg = conv2d(imatrix,newHaarkernel);
end
