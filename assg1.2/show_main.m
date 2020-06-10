%% This code is to show the keypoints and descriptors
%get the locs and descriptors of keypoints from sift and plot on the image
[image, descriptors, locs] = sift('im01.jpg');
%show the keypoints and the orientation arrows
figure(1);
showkeys(image, locs);
%show the descriptors of keypoints
%wait for a while when plotting the descriptors after the second image shown
figure(2);
showdescriptor(image, locs, descriptors);