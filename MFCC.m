function MFCCs = MFCC(filename,N,M)
    close all
    [x,Fs]=audioread(filename);
    sound(x,Fs)
    plot(x);
    if (size(x,2)==2)
        xl=x(:,1);
        xr=x(:,end);
        xfbl=FrameBlocking(xl,N,M);
        xfbr=FrameBlocking(xr,N,M);
        xwl=Window(xfbl);
        xwr=Window(xfbr);
        xpl=processingpart2(xwl,Fs);
        xpr=processingpart2(xwr,Fs);
        MFCCs=[xpl,xpr];
    end
end