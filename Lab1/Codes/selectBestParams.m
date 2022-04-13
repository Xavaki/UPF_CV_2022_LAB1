function bestChoiceTable = selectBestParams(T, paramNames)

    % number of detected features (numDetectedFeatures) 
    % mean metric score of detected features (meanScore) 
    % variance of location of detected features (varianceLocation_m, varianceLocation_n) 
    % mean metric score of top x strongest features (meanScoreTop) 
    % variance of location of top x strongest features
    % (varianceLocationTop_m, varianceLocationTop_n)
    
    % these meta-parameters might be dependant on the input image
    minNumFeatures = 50; 
    minScore = 50; 
    m = ...
        T.numDetectedFeatures >= minNumFeatures & ...
        T.meanScore >= minScore; 
    
    T = T(m,:);
    
    bestChoice_MAX = maxBest(T);
    bestChoice_MEAN = meanBest(T);
    default = T(T.is_default == 1,:);
   
    % some post-processing to display results properly
    bestChoiceTable = [bestChoice_MAX;bestChoice_MEAN;default];
    bestChoiceTable.Properties.VariableNames(1) = {char(join(paramNames,'_'))};
    
end 