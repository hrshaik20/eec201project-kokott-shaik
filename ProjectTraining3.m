% 2024 students' zero training and testing
close all
clear
% Get the training data filepaths
I=dir("Zero-Training\Zero_train*.wav");
% Elements per frame. 512 is sufficient for the 18/18 speakers in the
% training/testing datasets.
N=512;
% Distance between frame starts. 200 is sufficient for the 18/18 speakers in
% the training/testing datasets.
M=200;
% MFCC bins produced. 20 is sufficient for the 18/18 speakers in the
% training/testing datasets.
K=20;
% How many codewords to generate in the LBG algorithm, 2^NumIterations. 3
% is sufficient with the other settings for the 18/18 speakers in the
% training/testing datasets.
NumIterations=3;
% For each training data file:
for i=1:length(I)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    index=str2double(erase(I(i).name,[".wav","Zero_train"]));
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data{index}=MFCC(I(i).folder+"\"+I(i).name,N,M,K,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords{index}=LBGTraining(data{index},NumIterations,0.01,0.01,1,2,false);
end

% Get the test data filepaths
I2=dir("Zero-Testing\Zero_test*.wav");
% For each test data file:
for i=1:length(I2)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index (see above)
    index=str2double(erase(I2(i).name,[".wav","Zero_test"]));
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2{index}=MFCC(I2(i).folder+"\"+I2(i).name,N,M,K,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords)
        Distances{index,n}=disteu(Codewords{n},data2{index});
        Distortion(n)=sum(min(Distances{index,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist(index),speakerID(index)]=min(Distortion);
end
% Print the results!
disp(speakerID);