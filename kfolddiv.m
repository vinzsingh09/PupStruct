function kfoldpart = kfolddiv( kfold, sampledata )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    kfoldpart = cell(kfold, 3);
    samplesize = length(sampledata);
    samplesize_const = floor(samplesize/kfold);
    samplesize_rem = mod(samplesize,kfold);
    prev_value = 1;
    next_value = 0;
    for j=1:kfold
        kfoldpart{j,1} = j;
        if(samplesize_rem > 0)
            kfoldpart{j,2} = samplesize_const + 1;
            next_value = prev_value + samplesize_const;
        else
            kfoldpart{j,2} = samplesize_const ;
            next_value = prev_value + samplesize_const - 1;
        end
        
        kfoldpart{j,3} = [prev_value  next_value]; 
        prev_value = next_value + 1;
        
        samplesize_rem = samplesize_rem - 1;
    end
end


