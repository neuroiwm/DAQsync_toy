N = 500;
dinOrd = zeros(N,1);
tic
for i = 1 : 500
    din = randperm(size(OutputSignal_alt,3));
    D_out.write(OutputSignal_alt(:,:,din(1)));
    D_out.start();
    dinOrd(i)=din(1);
    pause(max(0.2,rand(1)))
end
a = toc;

save(['ResQDD_',expstr],'expstr','dinOrd','a')
stopDAQ;
movefile(sprintf('*%s*',expstr),['Result_',expstr]);