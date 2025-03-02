% Code for FFT, MF wrapping, and cepstrum steps
% FFT and Mel-Frequency Wrapping Blocks
% Take FFT of windowed frames
% windowed_frames is a placeholder for the output of windowing block
% N is the size of the frame that you choose
fft_output = fft(windowed_frames, N);

% Store number of mel-spectrum coefficients
% I'm starting with 20 as noted in the project presentation from class
% We can change this if necessary
K = 20;

% Use melfb to obtain matrix for mel-spaced filterbank
% fs is a placeholder for the sampling rate you choose
m = melfb(K, N, fs);

% Obtain the indices for the positive frequency coefficients of the fft
n2 = 1 + floor(N/2);

% Plotting the mel-spaced filterbank responses for test 3
freqs = linspace(0, fs/2, n2);
figure;
plot(x-axis, m');
xlabel('Frequency (Hz)');
title('Mel-Spaced Filterbank Responses');
grid on;

% Plotting first frame's power spectrum before mel-wrapping
figure;
plot(freqs, abs(fft_output(1:n2, 1)).^2);
xlabel('Frequency (Hz)');
ylabel('Power');
title('Power Spectrum Before Mel-Wrapping');
grid on;

% Obtain mel spectrum
mel_spectrum = m * abs(fft_output(1:n2)).^2;

% Plotting first frame's power spectrum after mel-wrapping
figure;
plot(1:K, mel_spectrum(:, 1));
xlabel('Index');
ylabel('Power');
title('Power Spectrum After Mel-Wrapping');
grid on;

% Mel Cepstrum Block
% Take the log of mel_spectrum as shown in the equation from slides
log_spectrum = log(mel_spectrum);

% Take DCT of previous result as shown in slides
mfcc = dct(log_spectrum);

% Ignore first coefficient as mentioned in slides
mfcc = mfcc(2:K, :);