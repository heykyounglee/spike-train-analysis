% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University

% Inputs:
%  in_filename: the input file (should be .xlsx)
%  out_filename: the output file (should be .xlsx)
%  tab: the tab of the input file containing the specific data
% Outputs:
%  No function outputs, but writes to output_filename

function [ ] = Automated_Proccessing(in_filename, out_filename, tab)

%Blank Col B
writeArray = cell(1,10);
writeArray{ 1, 1 } = 'Animal';
writeArray{ 1, 2 } = 'Electrode';
writeArray{ 1, 3 } = 'Layer';
writeArray{ 1, 4 } = 'Block';
writeArray{ 1, 5 } = 'Mean Burst Length';
writeArray{ 1, 6 } = 'Mean NonBurst Length';
writeArray{ 1, 7 } = 'Median Burst Length';
writeArray{ 1, 8 } = 'Median Nonburst Length';
writeArray{ 1, 9 } = 'Mean Burst Frequency (Hz)';
writeArray{ 1, 10 } = 'Mean Non-Burst Frequency(Hz)';
writeArray{ 1, 11 } = 'Frequency of Bursts (Bursts/Sec)';
writeArray{ 1, 12 } = 'Percent of Spikes in Burst';
writeArray{ 1, 13 } = 'STD of Bursts';

% Creates assumptions about the nummber of columns
% May need to be edited to fit the specific case
ranges = cell(2,26);
Alphabet = 'BCDEFGHIJKLMNOPQRSTUVWXYZ';
% Logic to read in the length of each column
for i = 1:25
    col_str = Alphabet(i);
    count = xlsread(in_filename,tab,[col_str '1']);
    end_num = 5+count;
    ranges{ 1, i, 1 } = [col_str '1:' col_str num2str(end_num)];
    ranges{ 1, i, 2 } = xlsread(in_filename,tab,[col_str '5']);
    if isempty(ranges{ 1, i, 2 })
        ranges{ 1, i, 2 } = '2&3';
    end
end

for jj = 1:25
    [ allData, ~, ~ ] = xlsread(in_filename,tab,ranges{ 1, jj, 1 });
    j = jj+1;
    writeArray{ j, 1 } = allData(3); %Animal
    writeArray{ j, 2 } = allData(4); %Electrode
    writeArray{ j, 3 } = ranges{ 1, jj, 2}; %Layer
    writeArray{ j, 4 } = allData(2); %Block

    data = allData(5:end);
    % Find the start and end of each burst according to (Chen, 2009)
    [ starts, ends ] = findBurstParameters(data);
    % Go through the processing pipeline to pull the important data
    [ meanBL, medBL, meanBF, meanNBL, medNBL, meanNBF, numBursts, timeRec, percentBurst ] = burstData( data, starts, ends );
    writeArray{ j, 5 } = meanBL;
    writeArray{ j, 6 } = meanNBL;
    writeArray{ j, 7 } = medBL;
    writeArray{ j, 8 } = medNBL;
    writeArray{ j, 9 } = meanBF;
    writeArray{ j, 10 } = meanNBF;
    writeArray{ j, 11 } = numBursts/timeRec;
    writeArray{ j, 12 } = percentBurst;
end

xlswrite(out_filename, writeArray, 1);
end