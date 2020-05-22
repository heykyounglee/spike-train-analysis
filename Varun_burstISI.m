clear all
out_filename = '20_01_03_L4.xlsx';
in_filename = 'Copy of ISI-DE_fromBetsy_040717.xlsx';
tab = 'DE+Blank';
layer = '4';
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
    else
        ranges{ 1, i, 2 } = num2str(ranges{ 1, i, 2 });
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

for jj = 1:25
    if ~(strcmp(ranges{1, jj, 2}, layer) || strcmp(layer, 'all'))
        disp(ranges{1,jj,2})
        continue
    end
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
edges = 0:0.001:0.2;
isis = [{ones}; {twos}; {threes}; {fours}]; i=1;
figure(1)
hold on;
% clearvars hist edges bins;
hist1 = histogram(ones,edges,'Normalization', 'probability');

% hist =[0 hist];
   
plot(edges(1:end-1),hist1)
set(gca, 'XLim',[0,0.1], 'YLim', [0,0.2]);    

hold off

figure(2)
edges = 0:0.001:0.2;
hold on;
% clearvars hist edges bins;
hist2 = histogram(twos,edges,'Normalization', 'probability');

% hist =[0 hist];
   
plot(edges(1:end-1),hist2)
set(gca, 'XLim',[0,0.1], 'YLim', [0,0.2]);    

hold off

figure(3)
edges = 0:0.001:0.2;
hold on;
% clearvars hist edges bins;
hist3 = histogram(threes,edges,'Normalization', 'probability');

% hist =[0 hist];
   
plot(edges(1:end-1),hist3)
set(gca, 'XLim',[0,0.1], 'YLim', [0,0.2]);    

hold off

figure(4)
edges = 0:0.001:0.2;
hold on;
% clearvars hist edges bins;
hist3 = histogram(fives,edges,'Normalization', 'probability');

% hist =[0 hist];
   
plot(edges(1:end-1),hist3)
set(gca, 'XLim',[0,0.1], 'YLim', [0,0.2]);    

hold off

names = { 'burst position', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', '8+' };
means = { 'mean', mean(ones), mean(twos), mean(threes), mean(fours), mean(fives), mean(sixs), mean(sevens), mean(eights), mean(pluss) };
stds = { 'std', std(ones), std(twos), std(threes), std(fours), std(fives), std(sixs), std(sevens), std(eights), std(pluss) };