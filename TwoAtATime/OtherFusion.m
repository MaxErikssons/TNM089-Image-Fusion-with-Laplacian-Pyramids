function img_output = OtherFusion(img_1, img_2, sz_h, sz_w)
[h, w, cc] = size(img_1);
img_output = zeros(h, w, cc, class(img_1));

ext_x = floor(sz_w / 2);
ext_y = floor(sz_h / 2);

% Extend input images with respect to the size of the sliding window
edge_x = zeros(h, ext_x, cc, class(img_1));
tem_img_1 = cat(2, edge_x, img_1, edge_x);
edge_y = zeros(ext_y, size(tem_img_1, 2), cc, class(img_1));
ext_img_1 = cat(1, edge_y, tem_img_1, edge_y);
tem_img_2 = cat(2, edge_x, img_2, edge_x);
ext_img_2 = cat(1, edge_y, tem_img_2, edge_y);

for y = 1:h
    for x = 1:w
        for c = 1:cc
            w_1 = ext_img_1(y:y+2*ext_y, x:x+2*ext_x, c);
            w_2 = ext_img_2(y:y+2*ext_y, x:x+2*ext_x, c);
            % Regional energy
            RE1 = abs(GetEnergy(w_1));
            RE2 = abs(GetEnergy(w_2));
            % Fusion strategy
            if RE1 >= RE2
                img_output(y, x, c) = img_1(y, x, c);
            elseif RE1 < RE2
                img_output(y, x, c) = img_2(y, x, c);
            end
        end
    end
end

img_output = squeeze(img_output);
end

