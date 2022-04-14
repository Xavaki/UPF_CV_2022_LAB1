function bestChoice = meanBest(T)
    %vars = ["meanScore", "varianceLocation_m", ...
    %   "varianceLocation_n", "meanScoreTop", "varianceLocationTop_m", ...
    %   "varianceLocationTop_n"];
    vars = ["meanScore", "meanScoreTop"];
    meanMetrics = mean(T{:,vars},2);
    [~, bestChoiceID] = max(meanMetrics); 
    bestChoice = T(bestChoiceID,:);
end 