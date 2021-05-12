%% sendNSandDAQ_Evt
try
    D_out.write(sendQue2NSandAnotherDAQ);
    D_out.start();
catch
    fprintf('delayed\n')
    pause(0.1);
    D_out.write(sendQue2NSandAnotherDAQ);
    D_out.start();
end
