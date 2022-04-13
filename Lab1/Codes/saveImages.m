function saveImages(functionHandle, image_file, bestChoiceTable, paramNames,valuesPerParam)
    I = readimage(image_file); 
    [~, image_name, ~] = fileparts(image_file); 
    paramValues = bestChoiceTable{:,1};
    for pv = 1:size(paramValues,1)
        pval = paramValues(pv,:);
        argcell = arguments2cell(I, paramNames, pval);
        features=functionHandle(argcell{:}); 
        f = figure('visible','off');
        imshow(I)
        hold on
        plot(features.Location(:,1),features.Location(:,2),'*r','MarkerSize',4)
        hold off
        if pv == 1
            type = 'MAX';
        elseif pv == 2
            type = 'MEAN';
        else
            type = 'DEFAULTARGS';
        end 
        title(append(char(functionHandle),'-',type));
        saveas(f,append('results/',char(functionHandle),'/',type,'_',image_name,'_',int2str(valuesPerParam),'.png')); 
    end 

end