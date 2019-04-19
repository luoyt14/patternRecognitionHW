clear all;
close all;
clc;


% 加载并预处理训练模板
tmp0 = imread('../train/0.bmp');
tmp1 = imread('../train/1.bmp');
tmp2 = imread('../train/2.bmp');
tmp3 = imread('../train/3.bmp');
tmp4 = imread('../train/4.bmp');
tmp6 = imread('../train/6.bmp');
tmp8 = imread('../train/8.bmp');
tmp9 = imread('../train/9.bmp');

index = [0,1,2,3,4,6,8,9];

tmp_raw = cell(1);
template = cell(1);

for a = 1:length(index)
    tmp_raw{a} = eval(strcat(['tmp',num2str(index(a))]));
    level = graythresh(tmp_raw{a});
    template{a} = im2bw(tmp_raw{a},level);  %二值化
    se = strel('disk',2);
    template{a} = imopen(template{a},se);  %圆盘型结构元素，开运算处理（先腐蚀后膨胀）
end

name_test = {'1.bmp', ...
    '2.bmp', ...
    '3.bmp', ...
    '4.bmp', ...
    '5.bmp', ...
    '6.bmp', ...
    '处理划痕.bmp', ...
    '处理噪声.bmp'};

figure;
subplot(1,8,1);
imshow(template{1});
subplot(1,8,2);
imshow(template{2});
subplot(1,8,3);
imshow(template{3});
subplot(1,8,4);
imshow(template{4});
subplot(1,8,5);
imshow(template{5});
subplot(1,8,6);
imshow(template{6});
subplot(1,8,7);
imshow(template{7});
subplot(1,8,8);
imshow(template{8});
suptitle('预处理后的模板图像');

step=1;     %步长


for k = 1:length(name_test)
    test_img = imread(strcat(['../test/',name_test{k}]));
    if length(size(test_img)) == 3
        test_img = rgb2gray(test_img);
    end
    test_img = double(test_img)/255;

    [row,col] = size(test_img);
    [img, x_cut, y_cut] = preprocessing(test_img);

    figure;
    subplot(2,1,1);
    imshow(img);
    title(strcat([name_test{k},'预处理后的测试图像']));
%     subplot(2,1,2);
%     imshow(test_img);
%     title(strcat([name_test{k},'标记出匹配区域的原图']));
%     hold on;
    detection_set =  zeros(0,7);
    for c = 1:length(template)
        [winr,winc] = size(template{c});
        len=floor((row-winr)/step)+1;
        wid=floor((col-winc)/step)+1;
        for m=1:len
            for n=1:wid
                %截取一小块图像
                P = img((m-1)*step+1:(m-1)*step+winr,(n-1)*step+1:(n-1)*step+winc);
                Q = template{c};
                P = double(P);
                Q = double(Q);
            
                R = (P(:)'*Q(:))/(norm(P(:))*norm(Q(:))+eps);
            
                if R>0.75
                    element = [(m-1)*step+1,(n-1)*step+1,winr,winc,R,index(c),0];
                    detection_set = [detection_set;element];
                    iMaxPos = (m-1)*step+1;
                    jMaxPos = (n-1)*step+1;
                
                    m0 = winr;
                    n0 = winc;
                    %     [iMaxPos,jMaxPos] = find(result > 0.75);
                
%                     plot(jMaxPos,iMaxPos,'*');%绘制最大相关点
%                     %用矩形框标记出匹配区域
%                     plot([jMaxPos,jMaxPos+n0-1],[iMaxPos,iMaxPos],'Linewidth',2);
%                     plot([jMaxPos+n0-1,jMaxPos+n0-1],[iMaxPos,iMaxPos+m0-1],'Linewidth',2);
%                     plot([jMaxPos,jMaxPos+n0-1],[iMaxPos+m0-1,iMaxPos+m0-1],'Linewidth',2);
%                     plot([jMaxPos,jMaxPos],[iMaxPos,iMaxPos+m0-1],'Linewidth',2);
%                     text(jMaxPos+n0/3,iMaxPos+m0/3,num2str(index(c)),'fontsize',12,'color','r');
                end
            end
        end
    end

    subplot(2,1,2);
    imshow(test_img);
    title(strcat([name_test{k},'模板匹配识别结果']));
    hold on;

    merged_set = merge(detection_set);

    for i = 1:length(merged_set(:,1))
        iMaxPos = merged_set(i,1);
        jMaxPos = merged_set(i,2);
        m0 = merged_set(i,3);
        n0 = merged_set(i,4) ;
        %     [iMaxPos,jMaxPos] = find(result > 0.75);

        plot(jMaxPos,iMaxPos,'*');%绘制最大相关点
        %用矩形框标记出匹配区域
        plot([jMaxPos,jMaxPos+n0-1],[iMaxPos,iMaxPos],'Linewidth',2);
        plot([jMaxPos+n0-1,jMaxPos+n0-1],[iMaxPos,iMaxPos+m0-1],'Linewidth',2);
        plot([jMaxPos,jMaxPos+n0-1],[iMaxPos+m0-1,iMaxPos+m0-1],'Linewidth',2);
        plot([jMaxPos,jMaxPos],[iMaxPos,iMaxPos+m0-1],'Linewidth',2);
        text(jMaxPos+n0/3,iMaxPos+m0/3,num2str(merged_set(i,6)),'fontsize',12,'color','r');
    end
    saveas(gcf,['../report/save',num2str(k),'.jpg']);
end