%% set the scale of the masks/scale up the kernel size
function newkernel = set_scale(kernel,kernel_size)
  s = size(kernel);
  newkernel = zeros(s(1)*kernel_size,s(2)*kernel_size);
  for i = 1:s(1)
      for j = 1:s(2)
          newkernel((i-1)*kernel_size+1:i*kernel_size,(j-1)*kernel_size+1:j*kernel_size) = kernel(i,j);
      end
  end
end