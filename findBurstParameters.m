% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University

% Inputs -
%  ISIData:      The read in data of inter-spike intervals
% Outputs -
%  finalStarts:  Indices of the start of each inter-burst interval
%  finalEnds:    Indices of the end of each inter-burst interval
%  avgThreshold: The threshold of bursting

function [ finalStarts, finalEnds, avgThreshold ] = findBurstParameters( ISIData ) 
    ISISize = length(ISIData);
    %Find the threshhold
    [ avgThreshold, meanISI1 ] = findThreshold( ISIData );
    %End finding threshold
    
    starts = [];
    ends = [];
    firstTime = 1;
    
    %Find start and ends of burst
    for startSpike = 1 : ISISize - 1
        for endSpike = startSpike + 1 : ISISize - 1
            meanOfGroup = mean(ISIData(startSpike : endSpike));
            endChecker = mean(ISIData(startSpike : endSpike + 1));
            %Checks done here:
            %ISI of the first spike must be < threshold
            %AND average ISI must be < threshold
            %AND either the end spike is greater than the threshold, or the following
            %spike is greater than the mean of the group.
            if ISIData(startSpike) < avgThreshold && meanOfGroup < avgThreshold && (endChecker > avgThreshold || ISIData(endSpike + 1) > meanISI1)
                if firstTime || endSpike ~= ends(end)
                    starts = [ starts startSpike ];
                    ends = [ ends endSpike ];
                    disp(endSpike - startSpike);
                    
                    firstTime = 0;
                    break;
                end
            end
            if ISIData(endSpike + 1) > meanISI1
                break;
            end
        end
    end
 
    inOut = zeros(1,length(ISIData));
    for i = 1:length(ISIData)
        for j = 1:length(starts)
            if i >= starts(j) && i <= ends(j)
                inOut(i) = 1;
            end
        end
    end
    
    finalStarts = [];
    finalEnds = [];
    
    inBurst = 0;
    for i = 1:length(inOut)
        if inBurst == 0 && inOut(i) == 1
            inBurst = 1;
            finalStarts = [ finalStarts, i ];
        elseif inBurst == 1 && inOut(i) == 0
            inBurst = 0;
            finalEnds = [ finalEnds, i ];
        end
    end
end