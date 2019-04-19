clear;
close all;
clc;

%% load data
TRAIN_FILE_FOLDER = '../train/';
TEST_FILE_FOLDER = '../test/';
IMAGE_SIZE = 19 * 19;

train_mat = read_train_images(TRAIN_FILE_FOLDER);

%% draw error curve
err_train = zeros(1, IMAGE_SIZE);
err_test_face = zeros(1, IMAGE_SIZE);
err_test_mine = zeros(1, IMAGE_SIZE);
train_image = [TRAIN_FILE_FOLDER, 'face00018.jpg'];
test_face_image = [TEST_FILE_FOLDER, 'face.jpg'];
test_mine_image = [TEST_FILE_FOLDER, 'nonface.jpg'];
for k = 1:IMAGE_SIZE
    [err_train(k), ~] = reconstruct(train_mat, train_image, k);
    [err_test_face(k), ~] = reconstruct(train_mat, test_face_image, k);
    [err_test_mine(k), ~] = reconstruct(train_mat, test_mine_image, k);
    disp(['k=', int2str(k), ',err_train=', num2str(err_train(k)), ...
          ',err_test_face=', num2str(err_test_face(k)), ...
          ',err_test_nonface=', num2str(err_test_mine(k)),]);
end
figure(1);
hold on;
plot(1:IMAGE_SIZE, err_train, 'm');
plot(1:IMAGE_SIZE, err_test_face, 'r');
plot(1:IMAGE_SIZE, err_test_mine, 'b');
xlabel('k')
ylabel('recontruct errors')
legend('error curve of train image', ...
       'error curve of test face image', ...
       'error curve of test nonface image')
   
%% draw reconstruct image
k_list = [10, 50, 100, 150, 200, 250, 300, 350, 361];
train_image = [TRAIN_FILE_FOLDER, 'face00018.jpg'];
test_face_image = [TEST_FILE_FOLDER, 'face.jpg'];
test_mine_image = [TEST_FILE_FOLDER, 'nonface.jpg'];
for t = 1:length(k_list)
    k = k_list(t);
    [~, img] = reconstruct(train_mat, train_image, k);
    imwrite(img, ['../results/face00018_',int2str(k),'.jpg'])
    [~, img] = reconstruct(train_mat, test_face_image, k);
    imwrite(img, ['../results/face_',int2str(k),'.jpg'])
    [~, img] = reconstruct(train_mat, test_mine_image, k);
    imwrite(img, ['../results/nonface_',int2str(k),'.jpg'])
end

%% compare Chinese face with Foreigner face
err_train = zeros(1, IMAGE_SIZE);
err_test_face = zeros(1, IMAGE_SIZE);
err_test_mine = zeros(1, IMAGE_SIZE);
train_image = [TRAIN_FILE_FOLDER, 'face00018.jpg'];
test_face_image = [TEST_FILE_FOLDER, 'face.jpg'];
test_mine_image = [TEST_FILE_FOLDER, 'mine2.jpg'];
for k = 1:IMAGE_SIZE
    [err_train(k), ~] = reconstruct(train_mat, train_image, k);
    [err_test_face(k), ~] = reconstruct(train_mat, test_face_image, k);
    [err_test_mine(k), ~] = reconstruct(train_mat, test_mine_image, k);
    disp(['k=', int2str(k), ',err_train=', num2str(err_train(k)),...
          ',err_test_face=', num2str(err_test_face(k)), ...
          ',err_test_mine=', num2str(err_test_mine(k)),]);
end
figure(1);
hold on;
plot(1:IMAGE_SIZE, err_train, 'm');
plot(1:IMAGE_SIZE, err_test_face, 'r');
plot(1:IMAGE_SIZE, err_test_mine, 'b');
xlabel('k')
ylabel('recontruct errors')
legend('error curve of train image', ...
       'error curve of test face image', ...
       'error curve of test mine image')

%% compare Cartoon face with Foreigner face
err_train = zeros(1, IMAGE_SIZE);
err_test_face = zeros(1, IMAGE_SIZE);
err_test_xiaobai = zeros(1, IMAGE_SIZE);
train_image = [TRAIN_FILE_FOLDER, 'face00018.jpg'];
test_face_image = [TEST_FILE_FOLDER, 'face.jpg'];
test_xiaobai_image = [TEST_FILE_FOLDER, 'xiaobai3.jpg'];
for k = 1:IMAGE_SIZE
    [err_train(k), ~] = reconstruct(train_mat, train_image, k);
    [err_test_face(k), ~] = reconstruct(train_mat, test_face_image, k);
    [err_test_xiaobai(k), ~] = reconstruct(train_mat, test_xiaobai_image, k);
    disp(['k=', int2str(k), ',err_train=', num2str(err_train(k)),...
          ',err_test_face=', num2str(err_test_face(k)), ...
          ',err_test_xiaobai=', num2str(err_test_xiaobai(k)),]);
end
figure(1);
hold on;
plot(1:IMAGE_SIZE, err_train, 'm');
plot(1:IMAGE_SIZE, err_test_face, 'r');
plot(1:IMAGE_SIZE, err_test_xiaobai, 'b');
xlabel('k')
ylabel('recontruct errors')
legend('error curve of train image', ...
       'error curve of test face image', ...
       'error curve of test xiaobai image')