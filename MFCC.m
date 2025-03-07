function MFCCs = MFCC(filename,N,M,K)
    close all
    [x,Fs]=audioread(filename);
    sound(x,Fs)
    plot(x);
    if (size(x,2)==2)
        x=(x(:,1)+x(:,end))/2;
    end
    xfb=FrameBlocking(x,N,M);
    xw=Window(xfb);
    xp=processingpart2(xw,Fs,K);
    MFCCs=xp;
    figure;
    imagesc(M/Fs*(1:size(MFCCs,2)),2:1:K,MFCCs)
    colorbar
end