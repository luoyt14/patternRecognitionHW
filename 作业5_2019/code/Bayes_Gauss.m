function Bayes_Gauss(w1, w2)
    %% 计算识别函数
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
    x_min = -15; x_max = 15;
    y_min = -15; y_max = 15;
    step = 0.2;
    [xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
    x = xx(:);
    y = yy(:);
    grid_point = [x, y];
    row = (y_max - y_min) / step + 1;
    col = (x_max - x_min) / step + 1;
    figure;
    axis([x_min, x_max, y_min, y_max])
    hold on;
    axis equal
    xlim([x_min,x_max])
    ylim([y_min,y_max])
    

    predict = diag(grid_point*(W_1-W_2)*grid_point')+grid_point*(w_1-w_2)+(w_10-w_20);
    predict = reshape(predict,row,col);
    pos = predict;
    pos(pos>=0) = 1;
    pos(pos<0) = 2;

    cmap = [1 0.8 0.8; 0.9 0.9 1];
    imagesc([x_min, x_max], [y_min, y_max], pos)
    colormap(cmap);
    scatter(w1(:,1),w1(:,2),30,'r','filled')
    scatter(w2(:,1),w2(:,2),30,'b','filled')
    scatter(M1(1),M1(2),80,'r','+')
    scatter(M2(1),M2(2),80,'b','*')
%     plot([M1(1),M2(1)],[M1(2),M2(2)], 'black', 'LineWidth', 1)
    legend('class1', 'class2', 'mean1', 'mean2','Location','southeast')
    title('正态分布时的贝叶斯分类结果')
    
    %% 绘制高斯分布密度函数
    gauss1 = exp(diag((grid_point-M1)*W_1*(grid_point-M1)'))/(2*pi*sqrt(det(Sigma1)));
    gauss2 = exp(diag((grid_point-M2)*W_2*(grid_point-M2)'))/(2*pi*sqrt(det(Sigma2)));
    gauss1 = reshape(gauss1,row,col);
    gauss2 = reshape(gauss2,row,col);
    figure;
    mesh(xx,yy,gauss1);
    hold on;
    mesh(xx,yy,gauss2);
    title('两个正态分布图像')
end

