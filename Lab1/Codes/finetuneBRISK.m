function finetuneBRISK(image_file, valuesPerParam)

    %   'MinContrast'  A scalar T, 0 < T < 1, specifying the minimum intensity
    %                  difference between a corner and its surrounding region,
    %                  as a fraction of the maximum value of the image class.
    %                  Increasing the value of T reduces the number of detected
    %                  corners.
    %
    %                  Default: 0.2
    %
    %   'NumOctaves'   Integer scalar, NumOctaves >= 0. Increase this value to
    %                  detect larger features. Recommended values are between 1
    %                  and 4. Setting NumOctaves to zero disables multi-scale
    %                  detection and performs the detection at the scale of I.
    %                  
    %                  Default: 4
    %
    %   'MinQuality'   A scalar Q, 0 <= Q <= 1, specifying the minimum accepted
    %                  quality of corners as a fraction of the maximum corner
    %                  metric value in the image. Larger values of Q can be
    %                  used to remove erroneous corners.
    % 
    %                  Default: 0.1
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    MinContrast = 0:1/(valuesPerParam-1):1;
    MinContrast(1) = 0.001; 
    MinContrast(end) = 0.999; 
    NumOctaves = 1:4; 
    MinQuality = 0:1/(valuesPerParam-1):1;
    paramNames = {'MinContrast','NumOctaves','MinQuality'}; % order MUST match here!  
    defaults = [0.2, 4, 0.1];
    handle = @detectBRISKFeatures;
    paramCombinations = allcomb(MinContrast, NumOctaves, MinQuality);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_','_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
    
    
    

end 