addpath('./subsrc/');
try
    offCaution;
catch
    startup_iwm;
    offCaution;
end

comptID = 1;               %1: PC for BCI, 2:PC for PsychoTB
devname = {'Dev2';'Dev2'}; %6F
devID   = devname{comptID};
setPara_DAQ;
%% initialize_DO
D_out=daq('ni');
D_out.addoutput(devID,[0 1 2 3],'voltage');
D_out.write(refleshDIN);
D_out.start();
%% initialize_DI
D_in = daq('ni');
switch comptID
    case 1
        D_in.addinput(devID,2,'Voltage');
    case 2
        D_in.addinput(devID,0,'Voltage');
end

D_in.Rate = Fs_DAQ;

for i_ch = 1 : size(D_in.Channels,2)
    D_in.Channels(1,i_ch).TerminalConfig = 'SingleEnded';
end

expstr                      = datenow();
fid1                        = fopen(sprintf('DAQsync_%s_%s.bin',devID,expstr),'w');
fid2                        = fopen(sprintf('DAQlog_%s_%s.bin',devID,expstr),'w');
D_in.ScansAvailableFcn      = @(src,evt) backFunc(src,evt,fid1,fid2,comptID);
D_in.ScansAvailableFcnCount = 100;
start(D_in,"Continuous");
%% GUI
close all
fsz      = 12;
list_PGM = {'sendAnotherDAQ','sendNSandDAQ','stopDAQ','RefleshDAQ'};
[GUI1,f1]= generateGUI(list_PGM);
[GUI2,f2]= generateGUI;
pos_f2   = f1.Position;
pos_f2(1)= pos_f2(1) + pos_f2(3);
pos_f2(3)= ceil(pos_f2(3)/3); setPos(pos_f2);
UI_Din   = uicontrol(f2,'style','edit','position',[pos_f2(3)-80,1,80 40],'fontsize',fsz,'String','1');
UI_DevID = uicontrol(f2,'style','Text','position',[1,1,80 40],'fontsize',fsz,'String',devID);
UI_DINNo = uicontrol(f2,'style','Text','position',[pos_f2(3)-80,40+1,80 40],'fontsize',fsz,'String','DIN NO.');




