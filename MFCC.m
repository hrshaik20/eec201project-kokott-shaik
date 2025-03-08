function MFCCs = MFCC(filename,N,M,K,showFigures)
    % Get the file data with audioread
    [x,Fs]=audioread(filename);
    if (showFigures)
        % Play the sound stored in the file
        sound(x,Fs)
        % Make a plot of the sound data
        plot(x);
    end
    % If the file is binaural, take the average of both sides
    if (size(x,2)==2)
        x=(x(:,1)+x(:,end))/2;
    end
    % Apply frame blocking to the sound data
    xfb=FrameBlocking(x,N,M);
    % Apply windowing to the frame-blocked data
    xw=Window(xfb);
    % FFT and Mel Spectrum/Cepstrum
    xp=processingpart2(xw,Fs,K,showFigures);
    % Assign the output of processingpart2 to the output of this function
    MFCCs=xp;
    if (showFigures)
        % Display the colormapped MFCC values
        figure;
        imagesc(M/Fs*(1:size(MFCCs,2)),2:1:K,MFCCs)
        colorbar
    end
end