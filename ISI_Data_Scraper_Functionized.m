% Created by Andrew Dykman
% In conjunction with the Mind Brain Institute at The Johns Hopkins University

% Inputs:
%  in_filename: the input file (should be .xlsx)
%  out_filename: the output file (should be .xlsx)
%  tab: the tab of the input file containing the specific data
%  cols_of_interest: an array of the columns to aggregate over
% Outputs:
%  No function outputs, but writes to output_filename

function [] = ISI_Data_Scraper(in_filename, out_filename, tab, cols_of_intereset)

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

ones = [];
twos = [];
threes = [];
fours = [];
fives = [];
sixs = [];
sevens = [];
eights = [];
pluss = [];

for jj = cols_of_interest
    [ allData, ~, ~ ] = xlsread(in_filename,tab,ranges{ 1, jj, 1 });
    data = allData(5:end);
    [ starts, ends ] = findBurstParameters(data);
    [ one, two, three, four, five, six, seven, eight, plux ] = burstHistogramData( data, starts, ends );
    ones = [ ones one ];
    twos = [ twos two ];
    threes = [ threes three ];
    fours = [ fours four ];
    fives = [ fives five ];
    sixs = [ sixs six ];
    sevens = [ sevens seven ];
    eights = [ eights eight ];
    pluss = [ pluss plux ];
end
clear one two three four five six seven eight plus;

names = { 'burst position', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', '8+' };
means = { 'mean', mean(ones), mean(twos), mean(threes), mean(fours), mean(fives), mean(sixs), mean(sevens), mean(eights), mean(pluss) };
stds = { 'std', std(ones), std(twos), std(threes), std(fours), std(fives), std(sixs), std(sevens), std(eights), std(pluss) };

write_array = [ names; means; stds ];
xlswrite(out_filename, write_array, 1);

end