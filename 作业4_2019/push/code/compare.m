clear;
close all;
clc;


%% load data
w1 = [1,1;2,0;2,1;0,2;1,3];
w2 = [-1,2;0,0;-1,0;-1,-1;0,-2];

%% ��Сŷʽ�������
plot_boundary(w1, w2, 1)

%% SVM����
plot_boundary(w1, w2, 2)