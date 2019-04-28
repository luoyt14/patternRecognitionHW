function plot_boundary(w1, w2, mode)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input: w1, w2, mode
%        mode=1: 最小欧式距离分类
%        mode=2: SVM分类
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    x_min = -2; x_max = 3;
    y_min = -3; y_max = 4;
    step = 0.05;
    [xx, yy] = meshgrid(x_min:step:x_max, y_min:step:y_max);
    x = xx(:);
    y = yy(:);
    grid_point = [x, y];
    row = (y_max - y_min) / step + 1;
    col = (x_max - x_min) / step + 1;
    figure;
    axis([x_min, x_max, y_min, y_max])
    hold on;
    
    if mode == 1
        M1 = mean(w1,1)';
        M2 = mean(w2,1)';
        
        d_1 = grid_point*M1 - 0.5*(M1)'*M1;
        d_2 = grid_point*M2 - 0.5*(M2)'*M2;
        d = [d_1, d_2];
        [~, pos] = max(d, [], 2);
    elseif mode == 2
        data = [w1; w2];
        label = zeros(1, size(data, 1));
        label(size(w1,1)+1:size(data,1)) = 1;
        model = fitcsvm(data, label);
        [pos, ~] = predict(model, grid_point);
    end
    
    pos = reshape(pos, row, col);
    cmap = [1 0.8 0.8; 0.9 0.9 1];
    imagesc([x_min, x_max], [y_min, y_max], pos)
    colormap(cmap);
    scatter(w1(:,1),w1(:,2),30,'r','filled')
    scatter(w2(:,1),w2(:,2),30,'b','filled')
    if mode == 1
        scatter(M1(1),M1(2),80,'r','+')
        scatter(M2(1),M2(2),80,'b','*')
        legend('class1', 'class2', 'mean1', 'mean2','Location','southeast')
        title('最小欧式距离分类结果')
    elseif mode == 2
        svInd = model.IsSupportVector;
        plot(data(svInd,1), data(svInd,2), 'ro', 'MarkerSize', 10)
        legend('class1', 'class2', 'Support Vectors', 'Location','southeast')
        title('SVM分类结果')
    end
end

