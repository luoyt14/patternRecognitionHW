function [img_roi] = myfilter(img)
%ȥ��������ͼƬ������
    img = medfilt2(img,[7,7]);
    [height, width] = size(img);
    cell_width = 10;
    cell_height = 10;
    for p=1:ceil(height/cell_height)
        for q=1:ceil(width/cell_width)
            block = img((p-1)*cell_height+1:min(p*cell_height, height),(q-1)*cell_width+1:min(q*cell_width, width));
            block = bioImage(block, 0.35);
            block = bioImage(block, 0.5);
            block = bioImage(block, 0.5);
            block(block<128) = 0;
            block(block>=128)=255;
            img((p-1)*cell_height+1:min(p*cell_height, height),(q-1)*cell_width+1:min(q*cell_width, width)) = block;
        end
    end
    % ʹ�ö��װ�����˹��ͨ�˲�����ͼ����и�ͨ��ǿ�˲�
    img = double(img);
    img_freq = fft2(img);
    img_freq = fftshift(img_freq);
    [M,N]=size(img_freq);
    nn=2;           % ���װ�����˹(Butterworth)��ͨ�˲���
    d0=10;
    m=floor(M/2); n=floor(N/2);
    result = zeros(M,N);
    for i=1:M
       for j=1:N
           d=sqrt((i-m)^2+(j-n)^2);
           h=1/(1+0.414*(d0/d)^(2*nn));  % �����ͨ�˲������ݺ���
           result(i,j)=h*img_freq(i,j);
       end
    end
    
    result=ifftshift(result);
    J2=ifft2(result);
    img_roi = uint8(real(J2));
    img_roi = img_roi+uint8(img);
    
end

