function finetuneFAST(image_file, valuesPerParam)

    %   'MinQuality'   A scalar Q, 0 <= Q <= 1, specifying the minimum accepted
    %                  quality of corners as a fraction of the maximum corner
    %                  metric value in the image. Larger values of Q can be
    %                  used to remove erroneous corners.
    % 
    %                  Default: 0.1
    %
    %   'MinContrast'  A scalar T, 0 < T < 1, specifying the minimum intensity
    %                  difference between a corner and its surrounding region,
    %                  as a fraction of the maximum value of the image class.
    %                  Increasing the value of T reduces the number of detected
    %                  corners.
    %
    %                  Default: 0.2
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    [~, image_name, ~] = fileparts(image_file); 
    MinQualityValues = 0:1/(valuesPerParam-1):1;
    MinContrastValues = 0:1/(valuesPerParam-1):1;
    MinContrastValues(1) = 0.001; 
    MinContrastValues(end) = 0.999; 
    paramNames = {'MinQuality' 'MinContrast'}; % order MUST match here! 
    paramCombinations = allcomb(MinQualityValues,MinContrastValues); 
    defaults = [0.1, 0.2];
    
    handle = @detectFASTFeatures; 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/bestChoice_','FAST','_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
    
    
    

end 