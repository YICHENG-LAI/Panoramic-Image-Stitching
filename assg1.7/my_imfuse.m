%% This code is to implement my_imfuse function
function newimg = my_imfuse(img1,img2)
%get image size W and H
img1_size = size(img1);
img2_size = size(img2);
W = max(img1_size(1),img2_size(1));
H = max(img1_size(2),img2_size(2));
%create new images of the same size(W,H,3)
n_img1 = zeros(W,H,3);
n_img1(1:img1_size(1),1:img1_size(2),:) = img1;
n_img2 = zeros(W,H,3);
n_img2(1:img2_size(1),1:img2_size(2),:) = img2;
newimg = zeros(W,H,3);
%composite of 2 images
for i = 1:W
    for j = 1:H
        if (sum(n_img1(i,j,:) > 0)) && (sum(n_img2(i,j,:) > 0))
            newimg(i,j,:) = 0.5*n_img1(i,j,:) + 0.5*n_img2(i,j,:);
        elseif n_img1(i,j,:) > 0
            newimg(i,j,:) = n_img1(i,j,:);
        else
            newimg(i,j,:) = n_img2(i,j,:);
        end
    end
end
newimg = newimg / max(max(max(newimg)));
%create masks to recover the intensity

end