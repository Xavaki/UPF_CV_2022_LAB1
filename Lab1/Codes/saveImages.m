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
            title_text = append(char(functionHandle),'-','MAX');
        elseif pv == 2
            title_text = append(char(functionHandle),'-','MEAN');
        else
            title_text = append(char(functionHandle),'-','DEFAULTARGS');
        end 
        title(title_text)
        saveas(f,append('results/',title_text,'-',image_name,'-',int2str(valuesPerParam),'.png')); 
    end 

end