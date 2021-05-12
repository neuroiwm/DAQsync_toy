function detectDIN(src, ~, fid,comptID)
[data, timestamps, ~] = read(src, src.ScansAvailableFcnCount,"OutputFormat", "Matrix");
data                  = [timestamps, data]';
[pks,loc]             = findpeaks(data(:,2),'MinPeakProminence',3);
if ~isempty(pks)
    fwrite(fid,loc,'double');
    if comptID == 2
        %%% psychoPC replies DIN from PC1
        Wrapper('sendNSandDAQ_Evt');
    end
end

end