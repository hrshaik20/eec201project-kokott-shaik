function m = melfb(p, n, fs)
% MELFB         Determine matrix for a mel-spaced filterbank
%
% Inputs:       p   number of filters in filterbank
%               n   length of fft
%               fs  sample rate in Hz
%
% Outputs:      x   a (sparse) matrix containing the filterbank amplitudes
%                   size(x) = [p, 1+floor(n/2)]
%
% Usage:        For example, to compute the mel-scale spectrum of a
%               colum-vector signal s, with length n and sample rate fs:
%
%               f = fft(s);
%               m = melfb(p, n, fs);
%               n2 = 1 + floor(n/2);
%               z = m * abs(f(1:n2)).^2;
%
%               z would contain p samples of the desired mel-scale spectrum
%
%               To plot filterbanks e.g.:
%
%               plot(linspace(0, (12500/2), 129), melfb(20, 256, 12500)'),
%               title('Mel-spaced filterbank'), xlabel('Frequency (Hz)');

% Here, 700 Hz is being used as the point before which filters are linearly
% spaced and after which they are log-spaced
% This first line of code normalizes this frequency by the chosen
% sampling frequency to obtain f0
f0 = 700 / fs;

% Here, we store the value of the FFT length divided by 2 in fn2
% This is referred to as the Nyquist bin index, which represents the
% highest frequency that can be captured in the FFT
% This is useful later as it allows us to make sure our final bin boundary
% index doesn't exceed this index value (i.e., is valid)
fn2 = floor(n/2);

% Here, we obtain the size of the logarithmic spacing between each filter.
% The numerator here essentially converts the Nyquist frequency to the mel 
% scale and then by dividing this by p + 1, we obtain the evenly spaced 
% filters in the mel scale
lr = log(1 + 0.5/f0) / (p+1);

% convert to fft bin numbers with 0 for DC term
% What is accomplished here is the conversion of mel-scaled frequencies
% to FFT bin indices. These bins are 0 for the DC term, the first mel
% filter boundary represented by 1, the last mel filter boundary 
% represented by p, and the Nyquist frequency represented by p + 1. By 
% multiplying the array in this equation by lr, we map these points to the
% mel scale and then by taking the exponent of this, we convert them back
% to linear frequencies. The array is then multiplied by f0 to obtain the
% frequencies in Hz for these bins and then multiplied by n to obtain the
% FFT bin indices.
bl = n * (f0 * (exp([0 1 p p+1] * lr) - 1));

% The FFT bin index computations from the previous step are adjusted here.
% The first index obtained in the previous step is rounded down to the 
% nearest integer and 1 is added just in case that value is 0 as we want 
% the first bin index to be at least 1.
b1 = floor(bl(1)) + 1;
% The second bin index is rounded up to the nearest integer.
b2 = ceil(bl(2));
% The third bin index is rounded down to the nearest integer.
b3 = floor(bl(3));
% The final bin index is defined as the minimum of either the
% Nyquist bin index or the final value from the previously calculated array
% rounded up to the nearest integer. 
b4 = min(fn2, ceil(bl(4))) - 1;

% Here, the calculated bin numbers are converted to frequencies and then
% these frequencies are mapped to the mel scale.
% pf contains the mel-scaled positions of the bins.
pf = log(1 + (b1:b4)/n/f0) / lr;
% Here, we store the integer that represents which filter a given bin
% belongs to. 
fp = floor(pf);
% Here, we store the decimal part of the mel-scaled position which
% indicates the position of the bin within the filter.
pm = pf - fp;

% Here, we obtain the row indices for the filterbank matrix. These indicate
% which filter a given frequency bin belongs to.
r = [fp(b2:b4) 1+fp(1:b3)];
% Here, we obtain the column indices for the filterbank matrix, indicating
% the FFT bin indices.
c = [b2:b4 1:b3] + 1;
% Here, we obtain the weights for the triangular filters.
v = 2 * [1-pm(b2:b4) pm(1:b3)];

% Finally, the sparse matrix for the mel-spaced filterbank is obtained with
% its rows corresponding to the p filters, its columns corresponding to the
% 1+fn2 frequency bins, and the its values corresponding to the weights of
% each filter.
m = sparse(r, c, v, p, 1+fn2);
