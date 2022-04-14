function finetuneSIFT(image_file, valuesPerParam)

    %   'ContrastThreshold' A non-negative scalar, 0 <= ContrastThreshold <= 1,
    %                       which specifies a contrast threshold for selecting
    %                       the strongest features. The contrast threshold is
    %                       used to filter out weak features in low-contrast
    %                       regions. Increasing the threshold decreases number
    %                       of returned features.
    %
    %                       Default: 0.0133
    %
    %   'EdgeThreshold'     A non-negative scalar, EdgeThreshold >= 1, which
    %                       specifies an edge threshold for filtering out
    %                       unstable edge-like features that are susceptible to
    %                       noise. Larger the EdgeThreshold, the less features
    %                       are filtered out.
    %
    %                       Default: 10.0
    %
    %   'NumLayersInOctave' Integer scalar, NumLayersInOctave >= 1, which
    %                       specifies the number of layers in each octave. The
    %                       number of octaves is computed automatically from
    %                       the image resolution. Increase this value to detect
    %                       larger features.
    %
    %                       Default: 3
    %
    %   'Sigma'             The sigma of the Gaussian applied to the input
    %                       image at the zeroth octave. Typical range is
    %                       between 1 and 2. If the image is blurry then
    %                       selecting a lower sigma value is recommended.
    %                     
    %                       Default: 1.6

    
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    ContrastThreshold = linspace(0,1,valuesPerParam); 
    EdgeThreshold = 1:2:12;
    NumLayersInOctave = 1:5;
    Sigma = linspace(1,2,valuesPerParam);
    paramNames = {'ContrastThreshold' 'EdgeThreshold','NumLayersInOctave', 'Sigma'}; % order MUST match here!  
    defaults = {0.0133, 10, 3, 1.6};
    handle = @detectSIFTFeatures;
    paramCombinations = allcomb(ContrastThreshold,EdgeThreshold,NumLayersInOctave,Sigma);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_','_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
end 