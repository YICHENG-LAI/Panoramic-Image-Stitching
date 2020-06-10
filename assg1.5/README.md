---------------------------------README-----------------------------------
--------------------------------Input data:------------------------------- 
im01.jpg;im02.jpg
-----------------------------------Run:-----------------------------------
just run Image_stitching_RANSAC.m to stitch the 2 images

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
result_show_stitched_image.fig
    This is the final result of stitching the imput images
result_show_best_matches.fig
    This shows the best match points
result_show_all_matches.fig
    This shows all the match points