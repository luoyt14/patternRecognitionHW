clear
clc
close all


%% load data
w1 = [3,4;3,8;2,6;4,6];
w2 = [3,0;3,-4;1,-2;5,-2];

%% 计算分类界面方程和识别函数
M1 = mean(w1, 1);
M2 = mean(w2, 1);
Sigma1 = cov(w1); %(w1-M1)'*(w1-M1)/3;
Sigma2 = cov(w2); %(w2-M2)'*(w2-M2)/3;
W_1 = -1/2*Sigma1^(-1);
W_2 = -1/2*Sigma2^(-1);
w_1 = Sigma1\M1';
w_2 = Sigma2\M2';
w_10 = -1/2*M1*w_1-1/2*log(det(Sigma1))+log(0.5);
w_20 = -1/2*M2*w_2-1/2*log(det(Sigma2))+log(0.5);

%% 绘制分类界面
x_min = -10; x_max = 10;
y_min = -10; y_max = 10;
step = 0.1;
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
grid_point = [x, y];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;


d_1 = grid_point*W_1*grid_point'+w_1'*grid_point'+w_10;
d_2 = grid_point*W_2*grid_point'+w_2'*grid_point'+w_20;
d = [d_1, d_2];
[~, pos] = max(d, [], 2);
pos = reshape(pos, row, col);
cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(w1(:,1),w1(:,2),30,'r','filled')
scatter(w2(:,1),w2(:,2),30,'b','filled')
scatter(M1(1),M1(2),80,'r','+')
scatter(M2(1),M2(2),80,'b','*')
legend('class1', 'class2', 'mean1', 'mean2','Location','southeast')
title('正态分布时的贝叶斯分类结果')