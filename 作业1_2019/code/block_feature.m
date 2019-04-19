function  F = block_feature(block)
%BLOCK_FEAURE Summary of this function goes here
%   Detailed explanation goes here
    [rowtr,coltr] = size(block);
    D = mat2cell(block,[floor(1/3*rowtr) floor(1/3*rowtr) rowtr-2*floor(1/3*rowtr)], ...
                             [floor(1/3*coltr) floor(1/3*coltr) coltr-2*floor(1/3*coltr)]);  %样本进行5*5分块
    ratio = [];
    for h =1:3
        for f = 1:3
            N = D{h,f};
            [v,~] = size(D{h,f});
            cf = sum(N)/v;
            ratio = [ratio,cf(:)'];       
        end
    end
    for h =1:3
        for f = 1:3
            N = D{h,f};
            [~,t] = size(D{h,f});
            rf = sum(N,2)/t;
            ratio = [ratio,rf(:)'];       
        end
    end
    F = ratio(:);
end

