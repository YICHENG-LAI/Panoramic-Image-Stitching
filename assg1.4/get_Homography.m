%% This code is to compute the homography matrix and transform the images
function H = get_Homography(x1,y1,x2,y2,n)


%% compute homography
A = [];
for i = 1:n
    A = [A;x1(i) y1(i) 1 0 0 0 -x1(i)*x2(i) -x2(i)*y1(i) -x2(i);
          0 0 0 x1(i) y1(i) 1 -x1(i)*y2(i) -y2(i)*y1(i) -y2(i)];
end
[~,~,V] = svd(A);
H = V(:,end);
H = reshape(H,[3,3]);

end