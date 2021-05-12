function logData(src, ~, fid)
[data, timestamps, ~] = read(src, src.ScansAvailableFcnCount,"OutputFormat", "Matrix");
data = [timestamps, data]';

fwrite(fid,data,'double');

end