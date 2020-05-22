clear all
out_filename = '20_01_03_L4.xlsx';
in_filename = 'Exemplar cells.xlsx';
g =xlsread(in_filename);
cells = g;
edges = 0:20:1000;
cells = cells*1000;

figure(1)
hold on
hist = histogram(cells(:,1),edges, 'Normalization', 'Probability', 'FaceColor', [0.1 0.1 0.1], 'EdgeColor','k');
hist = histogram(cells(:,3),edges, 'Normalization', 'Probability', 'FaceColor', 'b', 'EdgeColor','k');
set(gca, 'XLim',[0,800],'YLim',[0,0.12]); 
hold off

figure(2)
hold on
hist = histogram(cells(:,2),edges, 'Normalization', 'Probability');

set(gca, 'XLim',[0,1000],'YLim',[0,0.12]);  
hold off

figure(3)
hold on
hist = histogram(cells(:,3),edges, 'Normalization', 'Probability', 'FaceColor', ...
    [0 0 0], 'EdgeColor','none', 'FaceAlpha', 1);

set(gca, 'XLim',[0,1000],'YLim',[0,0.12]);  
hold off

spikeTimes = zeros(numel(cells(:,1))+1,1);

for i = 2:numel(spikeTimes)
    spikeTimes(i) = spikeTimes(i-1)+cells(i-1,1)/1000;
end
t = ones(numel(spikeTimes),1);
figure(4)
hold on
x = spikeTimes(:);
y = t(:);
d = t(:);


xx = [x, x, NaN(size(x))]';
yy = [y-d/2, y+d/2, NaN(size(y))]';
plot(xx,yy, 'b');
set(gca, 'yLim',[0,2], 'XLim', [0,200]);  
hold off

spikeTimes = zeros(numel(cells(:,2))+1,1);

for i = 2:numel(spikeTimes)
    spikeTimes(i) = spikeTimes(i-1)+cells(i-1,2)/1000;
end

t = ones(numel(spikeTimes),1);
figure(5)
hold on
x = spikeTimes(:);
y = t(:);
d = t(:);


xx = [x, x, NaN(size(x))]';
yy = [y-d/2, y+d/2, NaN(size(y))]';
plot(xx,yy, 'b');
set(gca, 'yLim',[0,2], 'XLim', [0,200]);  
hold off

spikeTimes = zeros(numel(cells(:,3))+1,1);

for i = 2:numel(spikeTimes)
    spikeTimes(i) = spikeTimes(i-1)+cells(i-1,3)/1000;
end

t = ones(numel(spikeTimes),1);
figure(6)
hold on
x = spikeTimes(:);
y = t(:);
d = t(:);


xx = [x, x, NaN(size(x))]';
yy = [y-d/2, y+d/2, NaN(size(y))]';
plot(xx,yy, 'b');
set(gca, 'yLim',[0,2], 'XLim', [0,200]);  
hold off
