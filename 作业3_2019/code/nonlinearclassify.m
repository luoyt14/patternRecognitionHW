clear;
close all;
clc;

w1 = [1,1;1,3;2,2;3,1;3,3];
w2 = [1,2;2,1;2,3;3,2];

%% 最小欧氏距离分类+非线性映射
w1_add = mykernel(w1(:,1), w1(:,2));
w2_add = mykernel(w2(:,1), w2(:,2));
w1_tp = [w1, w1_add];
w2_tp = [w2, w2_add];

x_min = 0; x_max = 4;
y_min = 0; y_max = 4;
step = 0.05;
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
grid_point = [x, y, mykernel(x, y)];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;
    
M1 = mean(w1_tp,1)';
M2 = mean(w2_tp,1)';
d_1 = grid_point*M1 - 0.5*(M1)'*M1;
d_2 = grid_point*M2 - 0.5*(M2)'*M2;
d = [d_1, d_2];
[~, pos] = max(d, [], 2);

pos = reshape(pos, row, col);
cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(w1(:,1),w1(:,2),30,'r','filled')
scatter(w2(:,1),w2(:,2),30,'b','filled')
legend('class1', 'class2')
title('最小欧式距离分类结果')

%% SVM+非线性映射
w1_add = mykernel(w1(:,1), w1(:,2));
w2_add = mykernel(w2(:,1), w2(:,2));
w1_tp = [w1, w1_add];
w2_tp = [w2, w2_add];

x_min = 0; x_max = 4;
y_min = 0; y_max = 4;
step = 0.05;
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
grid_point = [x, y, mykernel(x, y)];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;
    
data = [w1_tp; w2_tp];
label = zeros(1, size(data, 1));
label(size(w1,1)+1:size(data,1)) = 1;
model = fitcsvm(data, label);
[pos, ~] = predict(model, grid_point);

pos = reshape(pos, row, col);
cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(w1(:,1),w1(:,2),30,'r','filled')
scatter(w2(:,1),w2(:,2),30,'b','filled')
legend('class1', 'class2')
title('SVM分类+非线性映射结果')

%% SVM+核函数
x_min = 0; x_max = 4;
y_min = 0; y_max = 4;
step = 0.05;
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
grid_point = [x, y];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;
    
data = [w1; w2];
label = zeros(1, size(data, 1));
label(size(w1,1)+1:size(data,1)) = 1;
model = fitcsvm(data, label,'Standardize',true,...
    'KernelFunction','polynomial', 'KernelScale', 'auto');
[pos, ~] = predict(model, grid_point);

pos = reshape(pos, row, col);
cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(w1(:,1),w1(:,2),30,'r','filled')
scatter(w2(:,1),w2(:,2),30,'b','filled')
legend('class1', 'class2')
title('SVM+核函数分类结果')