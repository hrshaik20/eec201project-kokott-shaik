function Output = processingpart2(windowed_frames,fs,K,showFigures)
N=size(windowed_frames,1);
% Inputs: windowed_frames (matrix, whose columns are each one frame with a
% window applied to it); fs (the sampling frequency, which determines the
% frequency displayed on graphs); K (the number of bins for the mel-spaced
% filterbank); and showFigures (binary variable to toggle figures when
% using the function in the larger project)
%
% Code for FFT, MF wrapping, and cepstrum steps
% FFT and Mel-Frequency Wrapping Blocks
% Take FFT of windowed frames
% N is defined by the size of the input frames
for i=1:size(windowed_frames,2)
    fft_output(:,i) = fft(windowed_frames(:,i), N);
end

% Use melfb to obtain matrix for mel-spaced filterbank
m = melfb(K, N, fs);

% Obtain the indices for the positive frequency coefficients of the fft
n2 = 1 + floor(N/2);
freqs = linspace(0, fs/2, N);

if (showFigures)
    % Plotting the mel-spaced filterbank responses for test 3
    figure;
    plot(freqs(1:n2), m');
    xlabel('Frequency (Hz)');
    title('Mel-Spaced Filterbank Responses');
    grid on;

    % Plotting first frame's power spectrum before mel-wrapping
    figure;
    plot(freqs(1:n2), abs(fft_output(1:n2, 1)).^2);
    xlabel('Frequency (Hz)');
    ylabel('Power');
    title('Power Spectrum Before Mel-Wrapping');
    grid on;
end
% Obtain mel spectrum
mel_spectrum = m * abs(fft_output(1:n2,:)).^2;

if (showFigures)
    % Plotting first frame's power spectrum after mel-wrapping
    figure;
    plot(1:K, mel_spectrum(:, 1));
    xlabel('Index');
    ylabel('Power');
    title('Power Spectrum After Mel-Wrapping');
    grid on;
end

% Mel Cepstrum Block
% Take the log of mel_spectrum as shown in the equation from slides
log_spectrum = log(mel_spectrum);

% Take DCT of previous result as shown in slides
k=1:K;
for n=0:K-1
    Output(n+1,:)=log_spectrum'*cos(n*(k-1/2)*pi/K)';
end

% Ignore first coefficient as mentioned in slides
Output = Output(2:K, :);

end