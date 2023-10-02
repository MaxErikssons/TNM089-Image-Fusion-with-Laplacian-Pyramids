function laplacianPyramid = LaplacianPyramidDecomposition(folderPath, imageFiles, numLevels, grayscale)
laplacianPyramid =  cell(numel(imageFiles), numLevels);
for i = 1:numel(imageFiles)
    imagePath = fullfile(folderPath, imageFiles(i).name);
    img = imread(imagePath);
    if(grayscale)
        img = im2gray(img);
    end
    % Initialize the Laplacian pyramid cell array
    gaussianPyramid = GaussianPyramidDecomposition(img, numLevels);

    % Create the Laplacian Pyramid
    for j = 1:numLevels-1
        expandedImage = GaussianPyramidExpand(gaussianPyramid{j+1}, size(gaussianPyramid{j}));
        laplacianPyramid{i,j} = gaussianPyramid{j} - expandedImage;
    end

    % The last level of the Laplacian Pyramid is the same as the last level of the Gaussian Pyramid
    laplacianPyramid{i, numLevels} = gaussianPyramid{numLevels};
end
end

