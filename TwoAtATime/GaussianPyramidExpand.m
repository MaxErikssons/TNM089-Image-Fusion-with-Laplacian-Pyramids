function expandedImage = GaussianPyramidExpand(x, sz)
    kernel_a = 0.4;
    K = 2 * [0.25 - kernel_a/2, 0.25, kernel_a, 0.25, 0.25 - kernel_a/2];
    
    x = reshape(x, [size(x, 1), size(x, 2), size(x, 3)]); % Add an extra dimension if grayscale
    y = zeros([sz(1), sz(2), size(x, 3)]); % Store the result in this array
  
    for cc = 1:size(x, 3) % for each color channel
        y_a = zeros([size(x, 1), sz(2)]);
        % Step 1: upsample rows
        y_a(:, 1:2:end) = x(:, :, cc);
        % Step 2: filter rows
        y_a = conv2(y_a, K, 'same');
        % Step 3: upsample columns
        y(1:2:end, :, cc) = y_a;
        % Step 4: filter columns
        y(:, :, cc) = conv2(y(:, :, cc), K', 'same');
    end
    
    expandedImage = squeeze(y); % remove an extra dimension for grayscale images
end








