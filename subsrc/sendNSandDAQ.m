
din     = str2double(UI_Din.String);
try
    D_out.write(OutputSignal_alt(:,:,din));
    D_out.start();
catch
    fprintf('delayed\n')
    pause(0.1);
    D_out.write(OutputSignal_alt(:,:,din));
    D_out.start();
end
