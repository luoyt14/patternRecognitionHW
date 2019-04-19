function merged_set = merge(set)
%MERGE Summary of this function goes here
%   Detailed explanation goes here

K=length(set(:,1));

for m=1:K-1
    for n = m+1:K
        if(set(m,7) ==0 && ifoverlap(set(m,1),set(m,2),set(m,3),set(m,4), ...
                set(n,1),set(n,2),set(n,3),set(n,4)))
            if(set(m,5) > set(n,5))
                set(n,7) = 1;
            else
                set(m,7) = 1;
            end
        end
    end
end

index = find(set(:,7) == 0);

merged_set = set(index,:);

end

