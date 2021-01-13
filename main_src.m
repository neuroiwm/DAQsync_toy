addpath('./subsrc/');
comptID = 1;               %1: PC for BCI, 2:PC for PsychoTB
devname = {'Dev2';'Dev2'}; %6F
devID   = devname{comptID};
setPara_DAQ;
%% initialize_DO
D_out=daq.createSession('ni');
D_out.addAnalogOutputChannel(devID,[0 1 2 3],'voltage');
D_out.queueOutputData([0 0 0 0]);
D_out.startBackground();
%% initialize_DI
D_in = daq.createSession('ni');
D_in.addAnalogInputChannel(devID,0,'Voltage');

D_in.Rate                           = Fs_DAQ;
D_in.DurationInSeconds              = load_time;
D_in.NotifyWhenDataAvailableExceeds = Fs_DAQ;

for i_ch = 1 : size(D_in.Channels,2)
    D_in.Channels(1,i_ch).TerminalConfig = 'SingleEnded';
end

expstr = datenow();
fid1   = fopen(sprintf('DAQsync_%s_%s',devID,expstr),'w');
fid2   = fopen(sprintf('DAQlog_%s_%s',devID,expstr),'w');
lh1    = addlistener(D_in,'DataAvailable', @(src,event) logData(src,event,fid1));
lh2    = addlistener(D_in,'DataAvailable', @(src,event) detectDIN(src,event,fid2,comptID));
D_in.startBackground();
%% GUI
close all
fsz      = 18;
list_PGM = {'sendAnotherDAQ','sendNSandDAQ','stopDAQ'};
[GUI1,f1]= generateGUI(list_PGM);
[GUI2,f2]= generateGUI;
pos_f2   = f1.Position;
pos_f2(1)= pos_f2(1) + pos_f2(3);
pos_f2(3)= ceil(pos_f2(3)/3); setPos(pos_f2);
UI_Din   = uicontrol(f2,'style','edit','position',[pos_f2(3)-80,1,80 40],'fontsize',fsz,'String','1');
UI_DevID = uicontrol(f2,'style','Text','position',[1,1,80 40],'fontsize',fsz,'String',devID);
UI_DINNo = uicontrol(f2,'style','Text','position',[pos_f2(3)-80,40+1,80 40],'fontsize',fsz,'String','DIN NO.');




