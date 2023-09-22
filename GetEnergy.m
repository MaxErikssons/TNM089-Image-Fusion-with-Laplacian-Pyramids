function energy = GetEnergy(img)
    vec = img(:); % Flatten the image into a vector
    energy = sum(vec.^2); % Calculate the sum of squared pixel values
end