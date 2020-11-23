function knn_data_return = knn_data( summax, data)

    %summax = 50;

    trainfold = data;
    for j=1:length(trainfold)

        if(trainfold{j,3} == 1)
            trainfold{j,4} = 1;
        else

            sumzero = sum(trainfold{j,3}(1:summax,2));

            if (sumzero >= 1)
                trainfold{j,4} = 0;
            else
                trainfold{j,4} = 1;
            end
        end
    end


    samplesize=0;
    for j=1:length(trainfold)
        samplesize  = samplesize + trainfold{j,4};
    end

    s_i = 1;
    
    tempSampleData = cell(samplesize, 5);
    for j=1:length(trainfold)
        if(trainfold{j,4} == 1)
            tempSampleData(s_i,1:5) = trainfold(j,1:5);
            s_i = s_i + 1;
        end
    end
    
    knn_data_return = tempSampleData;
end