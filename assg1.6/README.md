---------------------------------README-----------------------------------
--------------------------------Input data:------------------------------- 
im01.jpg;im02,jpg;im03,jpg;im04,jpg;im05,jpg
-----------------------------------Run:-----------------------------------
just run Panoramic_image_stitching.m to stitch the 5 images

----------------------------------Files-----------------------------------
sift.m : 
    Function for getting keypoints
RANSAC_find_inliers.m :
    Finding most inliers by RANSAC
find_all_matches :
    Function to find all the match pairs between two images
get_Homoggraphy :
    Funtion to compute homography by input data
my_imfuse.m :
    Function to merge two images
Image_stitching_RANSAC.m :
    Function to automatically stitch two images

---------------------------------Output----------------------------------
result_stitch_all5pictures.jpg
    This is the final result of stitching the imput images