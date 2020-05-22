clear all
out_filename = '20_01_03_L4.xlsx';
in_filename = 'Copy of ISI-DE_fromBetsy_040717.xlsx';
tab = 'DE+Blank';
layer = 'all';
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
edges = 0:0.001:10;

[ allData, ~, ~ ] = xlsread(in_filename,tab);

for jj = 1:12
    if ~(strcmp(ranges{1, jj, 2}, layer) || strcmp(layer, 'all'))
        disp(ranges{1,jj,2})
        continue
    end
    figure(jj)
    hold on
    data = allData(6:end,jj);
    
    hist = histogram(data,edges,'Normalization', 'count');
    plot((0:0.001:0.02), hist.Values(1:21))
    set(gca, 'XLim',[-0.02,0.02]); 
    if hist.Values(2)>0.1
        violation(jj,1) = 1; 
        violation(jj,2) = hist.Values(2)/numel(data);
    end
    tredges = (-0.02:0.001:0.02);
    [N,~] = histcounts(data,(0:0.001:0.02));
    acg{jj} = [fliplr(N(2:end)) N];
    acg_viol(jj) = sum(N(1:2))/numel(data);
    plot(tredges(2:end-1),acg{jj});
    hold off
end
violation
acg_viol