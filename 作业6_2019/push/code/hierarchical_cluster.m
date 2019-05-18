clear
clc
close all


w1 = [2,0;2,2;2,4;3,3];
w2 = [0,3;-2,2;-1,-1;1,-2;3,-1];
w = [w1;w2];

Data = w;
X = w(:,1);
Y = w(:,2);
 
% ����ǰ�ߵ����ߵ����
disVector = pdist(Data, 'minkowski', inf); %'squaredeuclidean. chebychev'
 
% ת���ɷ���
disMatrix = squareform(disVector);
 
% ȷ����ξ����� 
treeCluster = linkage(disMatrix);
 
% ���ӻ�������
dendrogram(treeCluster);
 
% �����±�
idx = cluster(treeCluster,'maxclust',2); 
 
% ��ͼ
figure
axis equal
hold on;
x_min = -5; x_max = 10;
y_min = -5; y_max = 10;
axis([x_min, x_max, y_min, y_max])
 
% ��ͬ�ఴ�ղ�ͬ��ɫ���Ƴ���
for i = 1:9
   switch(idx(i))
       case 1
           scatter(X(i),Y(i),'ro', 'filled');
       case 2
           scatter(X(i),Y(i),'b*');
       otherwise
   end
end