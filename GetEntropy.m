function entropy = GetEntropy(img)
    vec = img(:); % Flatten the image into a vector
    total_pix = length(vec);
    prob = containers.Map(); % Create a Map object to store pixel probabilities

    % Find the probability of occurrence for each pixel value
    for i = 1:total_pix
        pix = num2str(vec(i)); % Convert to string to use as a key
        if isKey(prob, pix)
            prob(pix) = prob(pix) + 1;
        else
            prob(pix) = 1;
        end
    end

    % Normalize pixel probabilities
    valuesCell = values(prob);
    valuesArray = cell2mat(valuesCell);
    normalized_prob = valuesArray / total_pix;

    % Calculate the entropy of the input image
    entropy = -sum(normalized_prob .* log2(normalized_prob));
end

