
din     = str2double(UI_Din.String);    
try
    D_out.queueOutputData(OutputSignal_alt(:,din));
    D_out.startBackground();
catch
    fprintf('delayed\n')
    pause(0.1);
    D_out.queueOutputData(OutputSignal_alt(:,din));
    D_out.startBackground();
end
