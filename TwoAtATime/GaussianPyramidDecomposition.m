function gaussianPyramid = GaussianPyramidDecomposition(img, numLevels)
% Initialize the pyramid cell array
gaussianPyramid = cell(1, numLevels);

% Initialize the first level as the input image
gaussianPyramid{1} = im2double(img);

%% Create the Gaussian Pyramid 
% Can we use impyramid function or do we have to implement it by ourselves?
for i = 2:numLevels
    gaussianPyramid{i} = impyramid(gaussianPyramid{i-1}, 'reduce'); % Reduce the image size
end

end

