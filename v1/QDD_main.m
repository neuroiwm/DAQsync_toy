%% Quantify DIN Delay
d=dir('*.mat');
for i_d = 1 : numel(d)
    load(d(i_d).name,'evt_255_DINs');
    res = QDD(evt_255_DINs);
    figure; 
    histogram(res,'FaceColor',0.2*ones(3,1));
    title(sprintf('Distribution of DIN Delay,%0.2f ± %0.1f ms',mean(res),std(res)));
    setFig2(4,10);
    setLabel('Latency [ms]','Frequency');
end


%% local func
function res = QDD(evt_255_DINs)

str = cat(2,evt_255_DINs{1,:});
str = reshape(str,4,[]);
str = str(end,:);

Second = strfind(str,'8');
First  = find(~ismember(1:numel(str),Second));

First(diff(First)<2) = [];
DINtime   = cell2mat(evt_255_DINs(2,:));
idx_adopt = sort([First,Second]);
DINtime = DINtime(idx_adopt);
DINtime = reshape(DINtime,2,[]);
res     = diff(DINtime,1,1);
end