clear
clc
close all


%% base analysis
w1 = [3,4;3,8;2,6;4,6];
w2 = [3,0;3,-4;1,-2;5,-2];
Bayes_Gauss(w1, w2);

%% Advaced analysis
%Sigma1=Sigma2=sigma^2*I
w1_1 = [3,4;3,8;1,6;5,6];
w2_1 = [1,0;1,-4;-1,-2;3,-2];
Sigma1_1 = cov(w1_1);
Sigma2_1 = cov(w2_1);
Bayes_Gauss(w1_1, w2_1);

% Sigma1=Sigma2 不等于sigma^2*I
w1_2 = [3,4;3,8;2,6;4,6];
w2_2 = [1,0;1,-4;0,-2;2,-2];
Sigma1_2 = cov(w1_2);
Sigma2_2 = cov(w2_2);
Bayes_Gauss(w1_2, w2_2);

% 分类界面为圆
w1_3 = [3,5;3,7;2,6;4,6];
w2_3 = [3,0;3,-4;1,-2;5,-2];
Sigma1_3 = cov(w1_3);
Sigma2_3 = cov(w2_3);
Bayes_Gauss(w1_3, w2_3);

% 分类界面为椭圆
w1_4 = [3,4;3,8;2,6;4,6];
w2_4 = [3,1;3,-5;1,-2;5,-2];
Sigma1_4 = cov(w1_4);
Sigma2_4 = cov(w2_4);
Bayes_Gauss(w1_4, w2_4);

% 分类界面为双曲线
w1_5 = [3,4;3,8;2,6;4,6];
w2_5 = [3,-1;3,-3;1,-2;5,-2];
Sigma1_5 = cov(w1_5);
Sigma2_5 = cov(w2_5);
Bayes_Gauss(w1_5, w2_5);

% 分类界面为双曲线的渐近线
w1_6 = [3,4;3,8;2,6;4,6];
w2_6 = [4,3;8,3;6,2;6,4];
Sigma1_6 = cov(w1_6);
Sigma2_6 = cov(w2_6);
Bayes_Gauss(w1_6, w2_6);

