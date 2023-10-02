function img_output = TopFusion(pyramids, sz_h, sz_w)
% imageArray is a cell array containing the images to be fused

% Get the dimensions of the first image in the array
[h, w, cc] = size(pyramids{1});

% Initialize the output image
img_output = zeros(h, w, cc, class(pyramids{1}));

ext_x = floor(sz_w / 2);
ext_y = floor(sz_h / 2);

% Extend input images with respect to the size of the sliding window
extendedImages = cell(size(pyramids));
for i = 1:numel(pyramids)
    img = pyramids{i};
    edge_x = zeros(h, ext_x, cc, class(img));
    tem_img = cat(2, edge_x, img, edge_x);
    edge_y = zeros(ext_y, size(tem_img, 2), cc, class(img));
    extendedImages{i} = cat(1, edge_y, tem_img, edge_y);
end

for y = 1:h
    for x = 1:w
        for c = 1:cc
            % Initialize arrays to store statistics for each image
            deviations = zeros(1, numel(pyramids));
            entropies = zeros(1, numel(pyramids));

            % Calculate deviations and entropies for each image
            for i = 1:numel(pyramids)
                window = extendedImages{i}(y:y+2*ext_y, x:x+2*ext_x, c);
                deviations(i) = std2(window)^2;
                entropies(i) = GetEntropy(window);
            end

            % Determine the index of the image with the maximum deviation and entropy
            [~, maxDeviationIndex] = max(deviations);
            [~, maxEntropyIndex] = max(entropies);

            % Fusion strategy based on calculated coefficients
            if maxDeviationIndex == maxEntropyIndex
                img_output(y, x, c) = pyramids{maxDeviationIndex}(y, x, c);
            else
                img_output(y, x, c) = (pyramids{maxDeviationIndex}(y, x, c) + pyramids{maxEntropyIndex}(y, x, c)) / 2;
            end
        end
    end
end

img_output = squeeze(img_output);
end
