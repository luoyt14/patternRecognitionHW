function train_mat = read_train_images(filepath)
    IMAGE_SIZE = 19 * 19;
    train_image_list = dir(fullfile(filepath));
    train_num = size(train_image_list, 1) - 2;
    train_mat = zeros(train_num, IMAGE_SIZE);
    for k = 1:train_num
        img = imread([filepath, train_image_list(k+2).name]);
        img = reshape(img, 1, IMAGE_SIZE);
        train_mat(k,:) = double(img) / 255;
    end
end

