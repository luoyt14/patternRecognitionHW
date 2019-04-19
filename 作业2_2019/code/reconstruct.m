function [err, img_res] = reconstruct(train_mat, imgpath, k)
    [coeff, ~, ~] = pca(train_mat);
    img = imread(imgpath);
    img = reshape(img, 1, 19*19);
    img = double(img) / 255;
    y = coeff(:,1:k)'*(img-mean(img))';
    reconstruct_img = coeff(:,1:k)*y + mean(img);
    img_re = reshape(reconstruct_img, 1, 19*19);
    err = norm(img-img_re)^2;
    img_res = uint8(reshape(img_re, 19, 19)*255);
end

