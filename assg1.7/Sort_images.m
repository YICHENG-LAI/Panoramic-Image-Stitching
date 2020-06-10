%% This code is to sort the unordered images
function sorted_images = Sort_images(unordered_images)
%% read images
samples = length(unordered_images);

%% get distance of each images
ismatch = zeros(samples);
for i = 1:samples
    for j = 1:samples
        if j <= i
            continue;
        end
        [~,ismatch1] = RANSAC_find_inliers(unordered_images(i),unordered_images(j));
        ismatch(i,j) = ismatch1;
        ismatch(j,i) = ismatch(i,j);
    end
end

%% sort images based on distance 
for i = 1:samples
    if length(find(ismatch(i,:) == 1)) == 1
        continue
    end
    sequence = [i];
    break
end
% forward sort
for i = 1:samples
    m = length(sequence);
    next = find(ismatch(sequence(m),:) == 1);
    if isempty(next)
        break
    end
    for j = 1:length(next)
        if ~ismember(next(j),sequence)
            sequence = [sequence,next(j)];
            break
        end
    end
end
% backward sort
while length(sequence) < samples
    next = find(ismatch(sequence(1),:) == 1);
    if isempty(next)
        break
    end
    for j = 1:length(next)
        if ~ismember(next(j),sequence)
            sequence = [next(j),sequence];
            break
        end
    end
end
sorted_images = [];
for i = 1:samples
    sorted_images = [sorted_images,unordered_images(sequence(i))];
end