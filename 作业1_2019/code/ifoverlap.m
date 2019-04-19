function [Y,Z] = ifoverlap(x1,y1,r1,c1,x2,y2,r2,c2)
%ISOVERLAP Summary of this function goes here
%   Detailed explanation goes here
  Y=1;
  hinge = 0;
  if((x2-x1)>=r1-hinge)
    Y=0;
  elseif((x1-x2)>=r2-hinge)
    Y=0;
  elseif((y2-y1)>=c1-hinge)
    Y=0;
  elseif((y1-y2)>=c2-hinge)
    Y=0;
  end
  
end

