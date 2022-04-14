function finetuneHarris(image_file, valuesPerParam)

    %   'MinQuality'  A scalar Q, 0 <= Q <= 1, specifying the minimum accepted
    %                 quality of corners as a fraction of the maximum corner
    %                 metric value in the image. Larger values of Q can be used
    %                 to remove erroneous corners.
    % 
    %                 Default: 0.01
    %
    %   'FilterSize'  An odd integer, S >= 3, specifying a Gaussian filter 
    %                 which is used to smooth the gradient of the image.
    %                 The size of the filter is S-by-S and the standard
    %                 deviation of the filter is (S/3).
    %
    %                 Default: 5
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    MinQuality = linspace(0,1,valuesPerParam);
    FilterSize = 3:2:9; 
    paramNames = {'MinQuality' 'FilterSize'}; % order MUST match here!  
    defaults = [0.01, 5];
    handle = @detectHarrisFeatures;
    paramCombinations = allcomb(MinQuality,FilterSize);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults)
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
    
    
    

end 