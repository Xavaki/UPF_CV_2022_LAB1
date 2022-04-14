function finetuneKAZE(image_file, valuesPerParam)

    % 'Diffusion'         A string or character array specifying
    %                       the method to be used for computing the
    %                       conductivity based on first order derivatives of a
    %                       layer in scale space. Possible values are:
    %
    %                        'region'      - This option promotes wider 
    %                                        regions over smaller ones.
    %                        'sharpedge'   - This option promotes 
    %                                        high-contrast edges.
    %                        'edge'        - This option promotes 
    %                                        smoothing on both sides of 
    %                                        an edge stronger than 
    %                                        smoothing across it.
    %
    %                       Default: 'region'
    %
    %   'Threshold'         Double scalar, Threshold >= 0. Increase this value
    %                       to exclude less significant local extrema.
    %
    %                       Default: 0.0001
    %
    %   'NumOctaves'        Integer scalar, NumOctaves >= 1. Increase this
    %                       value to detect larger features. Recommended values
    %                       are between 1 and 4. Setting NumOctaves to one
    %                       disables multi-scale detection and performs the
    %                       detection at the scale of input image I.
    %
    %                       Default: 3
    %
    %   'NumScaleLevels'    Integer scalar, NumScaleLevels >= 3 and <= 10.
    %                       Increase this value to achieve smoother scale
    %                       changes, along with getting more intermediate
    %                       scales between octaves. Recommended values are
    %                       between 1 and 4.
    %
    %                       Default: 4
    
   
    % We declare an array with all possible parameter combinations 
    % And compute the results via generateFineTuneTable
    Diffusion = {'region', 'sharpedge', 'edge'};
    Threshold = linspace(0,4,valuesPerParam);
    Threshold(1) = 0.0001; 
    Threshold = num2cell(Threshold); 
    NumOctaves = num2cell(1:4); 
    NumScaleLevels = num2cell(3:10);  
    paramNames = {'Diffusion' 'Threshold','NumOctaves','NumScaleLevels'}; % order MUST match here!  
    defaults = {'region', 0.0001, 3, 4};
    handle = @detectKAZEFeatures;
    paramCombinations = allcomb(Diffusion,Threshold,NumOctaves,NumScaleLevels);
     
    mkdir(append('results/',char(handle))) 
    [~, image_name, ~] = fileparts(image_file); 
    resultsTable = generateFineTuneTable(image_file,handle, paramNames, paramCombinations, valuesPerParam, defaults);
    bestChoiceTable = selectBestParams(resultsTable, paramNames);
    saveImages(handle,image_file, bestChoiceTable,paramNames,valuesPerParam); 
    writetable(bestChoiceTable, append('results/',char(handle),'/','bestChoice_','_',image_name,'_',int2str(valuesPerParam),'.txt')); 
    
end 