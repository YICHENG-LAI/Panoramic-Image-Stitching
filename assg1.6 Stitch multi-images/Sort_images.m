%% This code is to sort the unordered images

%% read images
images =["im01.jpg";"im02.jpg";"im03.jpg";"im04.jpg";"im05.jpg"];
samples = length(images);

%% get distance of each images
distance = zeros(samples);
for i = 1:samples
    for j = 1:samples
        if j <= i
            continue;
        end
        inliers = RANSAC_find_inliers(images(i),images(j));
        distance(i,j) = length(inliers);
        distance(j,i) = distance(i,j);
    end
end

%% sort images based on distance 8+0.3*
sequence = [1];
% forward sort
while length(squence)
        tmpseq = find(distance(i,:) == max(distance(i,:)));
        j = 1;
        while ismember(tmpseq,sequence)
            tmp1 = sort(distance(i,:));
            tmpseq = find(distance(i,:) == tmp1(end-j));
            j = j+1;
        end
        sequence = [sequence,tmpseq];    
end
% backward sort
