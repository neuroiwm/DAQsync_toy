function backFunc(src, ~,fid1,fid2,comptID)
fprintf('!');
[data, timestamps, ~] = read(src, src.ScansAvailableFcnCount,"OutputFormat", "Matrix");
data                  = [timestamps, data];
%%% logData
fwrite(fid1,data','double');
%%% detectInput
[pks,loc]             = findpeaks(data(:,2),'MinPeakProminence',3);
if ~isempty(pks)
    fwrite(fid2,loc(1),'double');
    if comptID == 2
        %%% psychoPC replies DIN from PC1
        Wrapper('sendNSandDAQ_Evt');
    end
end

end