%% This function is to compute the convolution of matrix a and b
function c = conv2d(a, b) 
    % get array sizes
    [ma, na] = size(a);
    [mb, nb] = size(b);
   
    % do convolution
    c = zeros( ma+mb-1, na+nb-1 );
    for i = 1:mb
       for j = 1:nb
          r1 = i;
          r2 = r1 + ma - 1;
          c1 = j;
          c2 = c1 + na - 1;
         c(r1:r2,c1:c2) = c(r1:r2,c1:c2) + b(i,j) * double(a);
       end
    end