clear
clc
close all

%% read data and set parameters
X = load('testSet.txt');
N = size(X,1);
K = 4;

% K=3初始条件
init1 = [-4.822 4.607;-0.7188 -2.493;4.377 4.864];
init2 = [-3.594 2.857;-0.6595 3.111;3.998 2.519];
init3 = [-0.7188 -2.493;0.8458 -3.59;1.149 3.345];
init4 = [-3.276 1.577;3.275 2.958;4.377 4.864];

% K=2初始条件
init5 = [-4.822 4.607;4.377 4.864];
init6 = [1.149 3.345;-0.6595 -3.59];
init7 = [-4.822 4.607;1.149 0.6595];

% K=4初始条件
init8 = [-4.822 4.607;-1.149 -2.493;0.232, -3.222;4.377 4.864];

%% kmeans
a = randperm(N);
start_centroid = init8;
opts = statset('Display','iter');
[IDX, C, SUMD, D] = kmeans(X, K,'Start',start_centroid,'Options',opts, 'Distance', 'cityblock'); % sqeuclidean / cityblock

cmap = [1 0 0; 0 0 1; 0 1 0; 0.8, 0.8, 0.5];
class_label = 1:K;
class_label = class_label';
figure;
for i = 1:K
    ii=find(IDX==i);
    scatter(X(ii,1),X(ii,2),30,IDX(ii),'filled');
    hold on;
    scatter(start_centroid(i,1),start_centroid(i,2),100,class_label(i),'^');
    scatter(C(i,1),C(i,2),100,class_label(i),'o');
end
colormap(cmap(1:K,:))
title('Initial Centroids, Cluster Assignments and Final Centroids');