function [img] = bioImage(block, cond)
    block = double(block);
    block = block - mean(mean(block))*cond;
    block(block <= 0) = 0;
    maxblock = max(max(block));
    block = block/maxblock*255;
    img = uint8(block);
end