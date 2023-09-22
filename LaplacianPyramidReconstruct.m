function img = LaplacianPyramidReconstruct(pyramid)
    % Combine the levels of the Laplacian pyramid to reconstruct an image.
    levels = numel(pyramid);
    img = pyramid{levels};
    
    % Perform inverse operation to reconstruct the original image
    for i = 1:(levels - 1)
        img = GaussianPyramidExpand(img, size(pyramid{levels - i})) + pyramid{levels - i};
    end
end