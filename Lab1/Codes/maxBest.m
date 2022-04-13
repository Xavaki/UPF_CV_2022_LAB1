function bestChoice = maxScore(T)
    %[~,numDetectedFeatures_maxID] = max(T.numDetectedFeatures);
    [~,meanScore_maxID] = max(T.meanScore);
    [~,varianceLocation_m_maxID] = max(T.varianceLocation_m);
    [~,varianceLocation_n_maxID] = max(T.varianceLocation_n);
    [~,meanScoreTop_maxID] = max(T.meanScoreTop);
    [~,varianceLocationTop_m_maxID] = max(T.varianceLocationTop_m);
    [~,varianceLocationTop_n_maxID] = max(T.varianceLocationTop_n);
    
    maxIDS = [meanScore_maxID, varianceLocation_m_maxID, ...
        varianceLocation_n_maxID, meanScoreTop_maxID, ...
        varianceLocationTop_m_maxID, varianceLocationTop_n_maxID];
   
    bestChoiceID = mode(maxIDS); 
    bestChoice = T(bestChoiceID,:);
end 