clear;
close all;
clc;


%% load data
data = load('trainData.txt');
X = data(:,1:2);
Y = data(:,3)-1;
w1 = data(data(:,3)==1,1:2);
w2 = data(data(:,3)==2,1:2);

%% train KNN and plot boundary
for k=[1,3,5,7,69,199]
    mdl = fitcknn(X,Y,'NumNeighbors',k);
    x_min = -6; x_max = 6;
    y_min = -6; y_max = 6;
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

    [pos, ~] = predict(mdl, grid_point);
    pos = reshape(pos, row, col);
    cmap = [1 0.8 0.8; 0.9 0.9 1];
    imagesc([x_min, x_max], [y_min, y_max], pos)
    colormap(cmap);
    scatter(w1(:,1),w1(:,2),30,'r','filled')
    scatter(w2(:,1),w2(:,2),30,'b','filled')
    legend('class1', 'class2', 'Location','southeast')
    title(['k=',num2str(k),'时，KNN分类结果'])
end

%% accuracy vs k
klist = 1:2:199;
acclist = zeros(size(klist,2),1);
for k=klist
    mdl = fitcknn(X,Y,'NumNeighbors',k);
    [pos, ~] = predict(mdl, X);
    acclist((k+1)/2) = sum(pos==Y)/size(Y,1);
end
figure
plot(klist, acclist, 'LineWidth', 2)
xlabel('k')
ylabel('accuracy')
title('分类正确率与k的关系曲线')