clear
clc
close all


w1 = [2,0;2,2;2,4;3,3];
w2 = [0,3;-2,2;-1,-1;1,-2;3,-1];
w = [w1;w2];

Data = w;
X = w(:,1);
Y = w(:,2);
 
% 计算前边点与后边点距离
disVector = pdist(Data, 'minkowski', inf); %'squaredeuclidean. chebychev'
 
% 转换成方阵
disMatrix = squareform(disVector);
 
% 确定层次聚类树 
treeCluster = linkage(disMatrix);
 
% 可视化聚类树
dendrogram(treeCluster);
 
% 聚类下标
idx = cluster(treeCluster,'maxclust',2); 
 
% 画图
figure
axis equal
hold on;
x_min = -5; x_max = 10;
y_min = -5; y_max = 10;
axis([x_min, x_max, y_min, y_max])
 
% 不同类按照不同颜色绘制出来
for i = 1:9
   switch(idx(i))
       case 1
           scatter(X(i),Y(i),'ro', 'filled');
       case 2
           scatter(X(i),Y(i),'b*');
       otherwise
   end
end