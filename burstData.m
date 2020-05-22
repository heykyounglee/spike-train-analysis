% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University
% Creates summary statistics of the bursting patterns of a recording

% Inputs -
%  ISIData:   The read in data of inter-spike intervals
%  starts:    Indices of the start of each inter-burst interval
%  ends:      Indices of the end of each inter-burst interval
% Outputs -
%  meanBL:    Mean burst length
%  medBL:     Median burst length
%  meanBF:    Mean burst frequency
%  meanNBL:   Mean non-burst length
%  medNBL:    Median non-burst length
%  meanNBF:   Mean non-burst frequency
%  numBursts: Total number of bursts
%  timeRec:   Total time of the recording (sum of all ISIs)
%  percentBurst: Percent of spikes in burst
%  meanIBI:   Mean inter-burst interval
%  IBIstd:    inter-burst interval standard deviation (???TODO)


function [ meanBL, medBL, meanBF, meanNBL, medNBL, meanNBF, numBursts, timeRec, percentBurst, meanIBI, IBIstd ] = burstData( ISIData, starts, ends )
    %%Find burst length mean/median
    lengths = ends - starts;
    medBL = median(lengths);
    meanBL = mean(lengths);
    
    %%Find values inside of bursts
    valuesInBursts = [];
    for checkVal = 1:length(ISIData)
        for i = 1:length(starts)
            if checkVal > starts(i) && checkVal < ends(i)
                valuesInBursts = [ valuesInBursts checkVal ];
                break
            end
        end
    end
    
    %Find burst ISI
    totalBurstISIValue = 0;
    for i = 1:length(valuesInBursts)
        totalBurstISIValue = totalBurstISIValue + ISIData(valuesInBursts(i));
    end
    meanBurstISI = totalBurstISIValue / length(valuesInBursts);
    meanBF = 1 / meanBurstISI;    
    
    valuesOutBursts = [];
    for checkVal = 1:length(ISIData)
        if ~ismember(checkVal, valuesInBursts)
            valuesOutBursts = [ valuesOutBursts checkVal ];
        end
    end
    
    InterBurstIntervals = []; %Added 5/30/2017
    totalNonBurstISIValue = 0;
    IBI = 0;
    for i = 1:length(valuesOutBursts)
        totalNonBurstISIValue = totalNonBurstISIValue + ISIData(valuesOutBursts(i));
        %Looks for continuous streaks
        if i >= length(valuesOutBursts)
            %case of end of train
            InterBurstIntervals = [ InterBurstIntervals; IBI ];
            IBI = 0;
        elseif valuesOutBursts(i) + 1 ~= valuesOutBursts(i+1)
            %case of burst between ISIs
            InterBurstIntervals = [ InterBurstIntervals; IBI ];
            IBI = 0;
        else
            %case of IBI continuing
            IBI = IBI + ISIData(valuesOutBursts(i));
        end
    end
    
    meanIBI = mean(InterBurstIntervals);
    IBIstd = std(InterBurstIntervals);
    
    meanNonBurstISI = totalNonBurstISIValue / length(valuesOutBursts);
    meanNBF = 1/meanNonBurstISI;    
    
    outOfBurstLength = 1;
    outOfBurstArray = [];
    for i = 1:length(valuesOutBursts) - 1
        if valuesOutBursts(i) + 1 == valuesOutBursts(i + 1)
            outOfBurstLength = outOfBurstLength + 1;
        else
            outOfBurstArray = [ outOfBurstArray outOfBurstLength ];
            outOfBurstLength = 1;
        end
    end
    outOfBurstArray = [ outOfBurstArray outOfBurstLength ];
    
    meanNBL = mean(outOfBurstArray);
    medNBL  = median(outOfBurstArray);
    numBursts = length(lengths);
    timeRec = sum(ISIData);
    percentBurst = sum(lengths) / length(ISIData);
end