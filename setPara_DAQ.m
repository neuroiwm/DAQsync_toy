%% DO
OutputSignal=...
[5,0,0,0;...
    0,5,0,0;...
    5,5,0,0;...
    0,0,5,0;...
    5,0,5,0;...
    0,5,5,0;...
    5,5,5,0;...
    0,0,0,5;...
    5,0,0,5;...
    0,5,0,5;]; % DIN1~10

OutputSignal_alt=...
    [5,0,0,5;...
    0,5,0,5;...
    5,5,0,5;...
    0,0,5,5;...
    5,0,5,5;...
    0,5,5,5;...
    5,5,5,5;]; % DIN1~7 (Simulataneously Send to DI0 on DAQ2)

switch comptID
    case 1
        sendQue2AnotherDAQ      = [0 0 0 5]; % for DAQ1
    case 2
        sendQue2AnotherDAQ      = [5 0 0 0]; % for DAQ2
        sendQue2NSandAnotherDAQ = [5 0 0 5]; % for DAQ2
end
%% DI
Fs_DAQ    = 1000;
load_time = 1000;
sense     = 1;
datenow   = @()datestr(now,'yyyymmdd_HHMMSS');
