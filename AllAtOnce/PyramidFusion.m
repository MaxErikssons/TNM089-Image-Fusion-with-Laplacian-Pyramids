function [pyr_output] = PyramidFusion(pyramids)
[~, levels] = size(pyramids);
% Create an empty cell array of the same size
pyr_output = cell(1, levels);

for i = 1:levels
    if i == levels
        pyr_output{i} = TopFusion(pyramids(:, i), 3, 3);
    else
        pyr_output{i} = OtherFusion(pyramids(:, i), 3, 3);
    end
end

if numel(pyr_output) ~= levels
    disp('Error: Image fusion failed.');
    pyr_output = [];
end

end

