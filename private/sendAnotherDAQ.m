try
    D_out.queueOutputData(sendQue2AnotherDAQ);
    D_out.startBackground();
catch
    fprintf('delayed\n')
    pause(0.1);
    D_out.queueOutputData(sendQue2AnotherDAQ);
    D_out.startBackground();
end