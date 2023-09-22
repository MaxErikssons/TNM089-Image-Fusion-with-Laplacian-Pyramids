function laplacianPyramid = LaplacianPyramidDecomposition(img, numLevels)
% Initialize the Laplacian pyramid cell array
laplacianPyramid = cell(1, numLevels);
gaussianPyramid = GaussianPyramidDecomposition(img, numLevels);

% Create the Laplacian Pyramid
for i = 1:numLevels-1

    expandedImage = GaussianPyramidExpand(gaussianPyramid{i+1}, size(gaussianPyramid{i}));
    laplacianPyramid{i} = gaussianPyramid{i} - expandedImage;
end

% The last level of the Laplacian Pyramid is the same as the last level of the Gaussian Pyramid
laplacianPyramid{numLevels} = gaussianPyramid{numLevels};

end