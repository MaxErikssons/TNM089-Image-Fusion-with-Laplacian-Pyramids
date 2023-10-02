function [pyr_output] = PyramidFusion(pyr_1, pyr_2, grayscale)
pyr_output = cell(1, numel(pyr_1));
levels = numel(pyr_1);

for i = 1:levels
    temp_1 = pyr_1{i};
    temp_2 = pyr_2{i};

    % Reshape each layer if grayscale is required
    if grayscale
        temp_1 = reshape(temp_1, size(temp_1, 1), size(temp_1, 2), []);
        temp_2 = reshape(temp_2, size(temp_2, 1), size(temp_2, 2), []);
    end

    if i == levels
        pyr_output{i} = TopFusion(temp_1, temp_2, 3, 3);
    else
        pyr_output{i} = OtherFusion(temp_1, temp_2, 3, 3);
    end
end

if numel(pyr_output) ~= levels
    disp('Error: Image fusion failed.');
    pyr_output = [];
end

