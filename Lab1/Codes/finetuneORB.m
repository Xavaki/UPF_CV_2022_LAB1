function finetuneORB(image_file, valuesPerParam)

    %   points = detectORBFeatures(I) returns an ORBPoints object containing
    %   information about ORB keypoints detected in a 2-D grayscale image I.
    %   detectORBFeatures uses Gaussian pyramids to compute images at different
    %   scales and detect keypoints from those different levels. The function
    %   uses intensity centroids to calculate the orientation of the keypoints.
    %
    %   points = detectORBFeatures(I, Name, Value) specifies additional
    %   name-value pair arguments described below:
    %
    %   'ScaleFactor'   A scalar greater than 1, specifying the pyramid
    %                   decimation  ratio. Higher values reduce the number of
    %                   pyramid levels and speeds up computation. However, it
    %                   degrades the feature matching scores. Lower values
    %                   (slightly over 1) increase the number of pyramid levels
    %                   and improves the feature matching scores at the cost of
    %                   computation speed.
    %
    %                   Default: 1.2
    %
    %   'NumLevels'     An integer scalar greater than or equal to 1,
    %                   specifying the number of pyramid levels. Increase this
    %                   value to detect keypoints at more pyramid levels.
    %                   Along with 'ScaleFactor', this value controls the
    %                   number of pyramid levels on which the interest points
    %                   are evaluated.
    %
    %                   Default: 8
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    ScaleFactor = 1:1/(valuesPerParam-1):10;
    ScaleFactor(1) = 1.01;
    NumLevels = 5:10;
    paramNames = {'ScaleFactor' 'NumLevels'}; % order MUST match here!  
    defaults = [1.2, 8];
    handle = @detectORBFeatures;
    paramCombinations = allcomb(ScaleFactor,NumLevels);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_','_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
    
    
    

end 