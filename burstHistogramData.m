% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University
% Analyzes spiking patterns to find the stereotype of each position within a burst. Used in the ISI_Data_Scraper.m pipeline

% Inputs -
%  ISIData:   The read in data of inter-spike intervals
%  starts:    Indices of the start of each inter-burst interval
%  ends:      Indices of the end of each inter-burst interval
% Outputs -
%  one:      A list of all the ISIs from ISIData between the first and second spikes in a burst
%  two:      A list of all the ISIs from ISIData between the second and third spikes in a burst
%  three:    A list of all the ISIs from ISIData between the third and fourth spikes in a burst
%  four:     A list of all the ISIs from ISIData between the fourth and fifth spikes in a burst
%  five:     A list of all the ISIs from ISIData between the fifth and sixth spikes in a burst
%  six:      A list of all the ISIs from ISIData between the sixth and seventh spikes in a burst
%  seven:    A list of all the ISIs from ISIData between the seventh and eigth spikes in a burst
%  eight:    A list of all the ISIs from ISIData between the eigth and ninth spikes in a burst
%  plux:     A list of all the ISIs from ISIData after the ninth spike in a burst


function [ one, two, three, four, five, six, seven, eight, plux ] = burstHistogramData(ISIData, starts, ends)
    one = [];
    two = [];
    three = [];
    four = [];
    five = [];
    six = [];
    seven = [];
    eight = [];
    plux = [];
    for i = 1:length(starts)
        distance = ends(i) - starts(i);
        one = [ one ISIData(starts(i)) ];
        two = [ two ISIData(starts(i)+1) ];
        if distance > 3
            three = [ three ISIData(starts(i)+2) ];
        end
        if distance > 4
            four = [ four ISIData(starts(i)+3) ];
        end
        if distance > 5
            five = [ five ISIData(starts(i)+4) ];
        end
        if distance > 6
            six = [ six ISIData(starts(i)+5) ];
        end
        if distance > 7
            seven = [ seven ISIData(starts(i)+6) ];
        end
        if distance > 8
            eight = [ eight ISIData(starts(i)+7) ];
        end
        j = 8;
        while j < distance
            plux = [ plux ISIData(starts(i)+j) ];
            j = j+1;
        end
    end
end