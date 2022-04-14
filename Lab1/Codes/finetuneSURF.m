function finetuneSURF(image_file, valuesPerParam)

    %   'MetricThreshold'  A non-negative scalar which specifies a threshold
    %                      for selecting the strongest features. Decrease it to
    %                      return more blobs.
    %
    %                      Default: 1000.0
    %
    %   'NumOctaves'       Integer scalar, NumOctaves >= 1. Number of octaves 
    %                      to use. Increase this value to detect larger
    %                      blobs. Recommended values are between 1 and 4.
    %
    %                      Default: 3
    %
    %   'NumScaleLevels'   Integer scalar, NumScaleLevels >= 3. Number of
    %                      scale levels to compute per octave. Increase
    %                      this number to detect more blobs at finer scale 
    %                      increments. Recommended values are between 3 and 6.
    %
    %                      Default: 4
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    MetricThreshold = linspace(1,1000,valuesPerParam);
    NumOctaves = 1:4;  
    NumScaleLevels = 3:6;
    paramNames = {'MetricThreshold' 'NumOctaves','NumScaleLevels'}; % order MUST match here!  
    defaults = [1000, 3, 4];
    handle = @detectSURFFeatures;
    paramCombinations = allcomb(MetricThreshold,NumOctaves,NumScaleLevels);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
    
    
    

end 