% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University

% Inputs:
%  ISI_Data: An array of ISIs from a recording
% Outputs:
%  threshold: the threshold for bursting, using Chen (2009)'s methodology
%  meanISI1: an intermediate value that can be useful for data insight, the mean ISI

% Following Chen (2009), finds the threshold (ML) value for bursting
function [ threshold, meanISI1 ] = findThreshold( ISIData )
    meanISI1 = mean( ISIData );
    
    ISITemp = [];
    for ii = 1 : 1 : length(ISIData)
        if ISIData( ii ) < ( meanISI1 )
            ISITemp = [ ISITemp, ISIData(ii) ];
        end
    end
    
    threshold = mean( ISITemp );
    disp(threshold);
end