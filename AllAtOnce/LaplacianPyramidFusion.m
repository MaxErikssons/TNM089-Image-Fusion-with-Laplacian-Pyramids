function LaplacianPyramidFusion(folderPath, imageFiles, grayscale, levels)
imagePath = fullfile(folderPath, imageFiles(1).name);

img = imread(imagePath);
referenceSize = size(img);
for i = 2:numel(imageFiles)
    imagePath = fullfile(folderPath, imageFiles(i).name);
    img = imread(imagePath);
    imageSize = size(img);
    %% Check sizes of input images
    if ~isequal(imageSize, referenceSize)
        disp(['Error: Image ' num2str(i) ' size does not match the reference size.']);
        return;
    end
end

% Initialize time counter
tic;

%% Lacplacian Pyramid decomposition
pyramids = LaplacianPyramidDecomposition(folderPath, imageFiles, levels,grayscale);
pyramid_f = PyramidFusion(pyramids);

img_f = LaplacianPyramidReconstruct(pyramid_f);

processingTime = toc;
fprintf('Processing time = %f s\n', processingTime);

% Visualize fused Laplacian pyramid
%     figure;
%     for i = 1:numel(pyramid_f)
%         subplot(1, numel(pyramid_f), i);
%         imshow(pyramid_f{i});
%         title(['Level ' num2str(i)]);
%     end

% Show final image
figure;
title('Fused Image');
if grayscale
    imshow(img_f, 'InitialMagnification', 'fit');
    imwrite(img_f, 'result_grayscale.png');
else
    imshow(img_f, 'InitialMagnification', 'fit');
    imwrite(img_f, 'result_rgb.png');
end
end