function [W0, y0] = fisherclassify(w1, w2)
M1 = mean(w1,2);
M2 = mean(w2,2);
S1 = (w1-M1)*(w1-M1)';
S2 = (w2-M2)*(w2-M2)';
Sw = S1+S2;
% SB = (M1-M2)*(M1-M2)';
W = Sw\(M1-M2);
W0 = W / norm(W,2);
% y0 = W0'*(M1+M2)/2;
y0 = (size(w1, 2)*W0'*M1+size(w2, 2)*W0'*M2)/(size(w1, 2)+size(w2, 2));

x_min = -3; x_max = 4;
y_min = -3; y_max = 5;
step = 0.01;
xt = x_min:step:x_max;
yt = (y0-W0(1)*xt)/W0(2);
[xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
x = xx(:);
y = yy(:);
grid_point = [x, y];
row = (y_max - y_min) / step + 1;
col = (x_max - x_min) / step + 1;
figure;
axis([x_min, x_max, y_min, y_max])
hold on;

pos = (grid_point * W0)<y0;
pos = reshape(pos, row, col);
cmap = [1 0.8 0.8; 0.9 0.9 1];
imagesc([x_min, x_max], [y_min, y_max], pos)
colormap(cmap);
scatter(w1(1,:),w1(2,:),30,'r','filled')
scatter(w2(1,:),w2(2,:),30,'b','filled')
plot(xt, yt, 'black', 'LineWidth', 2)
legend('class1', 'class2', '分类界面')
title('Fisher判别分析分类结果')


end

