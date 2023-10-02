function LaplacianPyramidFusion(img_1, img_2, grayscale, levels)
    %% Check sizes of input images
    if ~isequal(size(img_1), size(img_2))
        disp('Error: Image sizes do not match.');
        return;
    end

    %% grayscale true / false ?
    if size(img_1, 3) == 3
        img_1 = im2double(img_1);
        img_2 = im2double(img_2);
        if grayscale
            img_1 = rgb2gray(img_1);
            img_2 = rgb2gray(img_2);
        end
    elseif size(img_1, 3) == 1
        img_1 = im2double(img_1);
        img_2 = im2double(img_2);
        disp('Input images are in grayscale.');
        grayscale = true;
    else
        disp('Error: Image sizes are invalid.');
        return;
    end

    % Initialize time counter
    tic;

    %% Lacplacian Pyramid decomposition
    pyramid_1 = LaplacianPyramidDecomposition(img_1, levels);
    pyramid_2 = LaplacianPyramidDecomposition(img_2, levels);
    pyramid_f = PyramidFusion(pyramid_1, pyramid_2, grayscale);

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