function finetuneMSER(image_file, valuesPerParam)

    %   regions = detectMSERFeatures(I) returns an MSERRegions object, regions,
    %   containing region pixel lists and other information about MSER features
    %   detected in a 2-D grayscale image I. detectMSERFeatures uses Maximally
    %   Stable Extremal Regions (MSER) algorithm to find regions.
    %
    %   [..., cc] = detectMSERFeatures(I) optionally returns MSER regions in a
    %   connected component structure. This output is useful for measuring
    %   region properties using the <a href="matlab:help regionprops">regionprops</a> function. The connected
    %   component structure, cc, contains four fields:
    %
    %       Connectivity   Connectivity of the MSER regions (default is 8)
    %
    %       ImageSize      Size of I.
    %
    %       NumObjects     Number of MSER regions in I.
    %
    %       PixelIdxList   1-by-NumObjects cell array where the kth element
    %                      in the cell array is a vector containing the linear
    %                      indices of the pixels in the kth MSER region.
    %
    %   regions = detectMSERFeatures(I,Name,Value) specifies additional
    %   name-value pair arguments described below:
    %
    %   'ThresholdDelta'   Scalar value, 0 < ThresholdDelta <= 100, expressed
    %                      as a percentage of the input data type range. This
    %                      value specifies the step size between intensity
    %                      threshold levels used in selecting extremal regions
    %                      while testing for their stability. Decrease this
    %                      value to return more regions. Typical values range
    %                      from 0.8 to 4.
    %
    %                      Default: 2
    %
    %   'RegionAreaRange'  Two-element vector, [minArea maxArea], which
    %                      specifies the size of the regions in pixels. This
    %                      value allows the selection of regions containing
    %                      pixels between minArea and maxArea, inclusive.
    %
    %                      Default: [30 14000]
    %
    %   'MaxAreaVariation' Positive scalar. Increase this value to return a
    %                      greater number of regions at the cost of their
    %                      stability. Stable regions are very similar in
    %                      size over varying intensity thresholds. Typical
    %                      values range from 0.1 to 1.0.
    %
    %                      Default: 0.25
   
    
    % not implemented due to time constraints

end 