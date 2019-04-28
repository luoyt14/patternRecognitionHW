clear;
close all;
clc;


%% load data
X = [1,1;2,0;2,1;0,2;1,3];
Y = [-1,2;0,0;-1,0;-1,-1;0,-2];

%% preprocess
b = ones(size(X,1),1);
X_pad = [X,b];
Y_pad = [Y,b];
Z = [X_pad;-Y_pad];

%% 迭代修正求权向量
% W = rand(size(Z,2), 1);
iternum = 0;
W = zeros(size(Z,2), 1);
c = 1;
while(true)
    if all(W'*Z'>0)
        break
    end
    W = W + c * mean(Z(W'*Z'<=0,:,:))';
    iternum = iternum + 1;
end

%% 绘制分类界面
x_min = -2; x_max = 3;
y_min = -3; y_max = 4;
step = 0.01;
xt = x_min:step:x_max;
yt = (-W(3)-W(1)*xt)/W(2);
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
bias = ones(size(x,1), 1);
grid_point = [x, y, bias];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;

pos = (grid_point * W)<0;
pos = reshape(pos, row, col);

cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(X(:,1),X(:,2),30,'r','filled')
scatter(Y(:,1),Y(:,2),30,'b','filled')
plot(xt, yt, 'black', 'LineWidth', 2)
legend('class1', 'class2', '分类界面')
title('迭代修正权向量法分类结果')
