function argcell = arguments2cell(I, paramNames, paramValues) 
    % Converts desired algorithm arguments into cell
    % Useful for dinamically calling each feature detection algorithm
    numOptionalParams = size(paramNames,2); 
    numParamsTotal = numOptionalParams*2+1; 
    argcell = cell(1,numParamsTotal); 
    argcell{1} = I; 
    for p = 2:2:numParamsTotal
        argcell{p} = char(paramNames(p/2)); 
        argcell{p+1} = paramValues(p/2); 
        if isa(paramValues(p/2),'cell')
            aux = paramValues(p/2); 
            argcell{p+1} = aux{1};
        end 
    end 
end 