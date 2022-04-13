function rt = generateFineTuneTable(image_file, functionHandle, paramNames, paramCombinations, valuesPerParam, defaults)

    %   For each posible combination of params, record: 
    %   number of detected features 
    %   mean metric score of detected features
    %   variance of location of detected features
    %   mean metric score of top x strongest features 
    %   variance of location of top x strongest features 
    %   computation time 
    %   (Save results in a table) 

    % We read the provided image file
    I = readimage(image_file); 
    [~, image_name, ~] = fileparts(image_file); 

    
    numTopFeatures = 20; 
    numComb = size(paramCombinations, 1); 
    
    % We initialize metric arrays, to be converted to table later
    numDetectedFeatures = zeros(1,numComb); 
    meanScore = zeros(1,numComb); 
    varianceLocation = zeros(numComb,2); 
    meanScoreTop = zeros(1,numComb); 
    varianceLocationTop = zeros(numComb,2); 
    computationTime = zeros(1,numComb); 
    is_default = logical(zeros(numComb,1)); 

    % For each parameter combination, we run the algorithm and record
    % metrics of interest 
    for pcomb = 1:numComb 
        argcell = arguments2cell(I, paramNames, paramCombinations(pcomb,:));
        tic 
        features=functionHandle(argcell{:}); 
        computationTime(pcomb) = toc; 
        numDetectedFeatures(pcomb) = features.Count; 
        meanScore(pcomb) = mean(features.Metric);
        varianceLocation(pcomb,:) = var(features.Location);
        if features.Count >= numTopFeatures
            meanScoreTop(pcomb) = mean(features.Metric(1:numTopFeatures));
            varianceLocationTop(pcomb,:) = var(features.Location(1:numTopFeatures,:));
        end 
    end 
    
    %we also include the default parameter choice
    paramCombinations(end+1,:) = defaults; 
    features=functionHandle(I); 
    computationTime(end+1) = toc; 
    numDetectedFeatures(end+1) = features.Count; 
    meanScore(end+1) = mean(features.Metric);
    varianceLocation(end+1,:) = var(features.Location);
    if features.Count >= numTopFeatures
        meanScoreTop(end+1) = mean(features.Metric(1:numTopFeatures));
        varianceLocationTop(end+1,:) = var(features.Location(1:numTopFeatures,:));
    end
    is_default(end+1) = 1;
    
    %paramCombinations; 
    numDetectedFeatures = numDetectedFeatures'; 
    meanScore = meanScore';
    varianceLocation_m = varianceLocation(:,1);
    varianceLocation_n = varianceLocation(:,2);
    meanScoreTop = meanScoreTop'; 
    varianceLocationTop_m = varianceLocationTop(:,1);
    varianceLocationTop_n = varianceLocationTop(:,2);
    computationTime = computationTime'; 
    
    % We convert results into a table and save it in a file
    rt = table(paramCombinations,numDetectedFeatures,meanScore,varianceLocation_m,...
        varianceLocation_n,meanScoreTop,varianceLocationTop_m, varianceLocationTop_n, computationTime, is_default);
    writetable(rt,append('results/fineTuneTable_',char(functionHandle),'_',image_name,'_',int2str(valuesPerParam),'.txt'));
end 