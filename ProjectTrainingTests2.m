close all
clear
% Get the training data filepaths
I=dir("2024StudentAudioRecording\Zero-Training\Zero_train*.wav");
% Elements per frame. 512 is sufficient for the 11/8 speakers in the
% training/testing datasets.
N=512;
% Distance between frame starts. 200 is sufficient for the 11/8 speakers in
% the training/testing datasets.
M=200;
% MFCC bins produced. 20 is sufficient for the 11/8 speakers in the
% training/testing datasets.
K=20;
% How many codewords to generate in the LBG algorithm, 2^NumIterations. 3
% is sufficient with the other settings for the 11/8 speakers in the
% training/testing datasets.
NumIterations=3;
% For each training data file:
for i=1:length(I)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data{i}=MFCC(I(i).folder+"\"+I(i).name,N,M,K,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords{i}.value=LBGTraining(data{i},NumIterations,0.01,0.01,1,2,false);
    Codewords{i}.set="Zero";
    Codewords{i}.ID=erase(I(i).name,[".wav","Zero_train"]);
end
I=dir("2024StudentAudioRecording\Twelve-Training\Twelve_train*.wav");
Temp=length(Codewords);
for i=1:length(I)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data{i+Temp}=MFCC(I(i).folder+"\"+I(i).name,N,M,K,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords{i+Temp}.value=LBGTraining(data{i+Temp},NumIterations,0.01,0.01,1,2,false);
    Codewords{i+Temp}.set="Twelve";
    Codewords{i+Temp}.ID=erase(I(i).name,["Twelve_train",".wav"]);
end

% Get the test data filepaths
I2=dir("2024StudentAudioRecording\Zero-Testing\Zero_test*.wav");
I2=[I2;dir("2024StudentAudioRecording\Twelve-Testing\Twelve_test*.wav")];
% For each test data file:
for i=1:length(I2)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index (see above)
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2{i}=MFCC(I2(i).folder+"\"+I2(i).name,N,M,K,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords)
        Distances{i,n}=disteu(Codewords{n}.value,data2{i});
        Distortion(n)=sum(min(Distances{i,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist(i),speakerID(i)]=min(Distortion);
end
TestResults=Codewords{1}.set+Codewords{1}.ID;
for i=2:length(speakerID)
    TestResults=TestResults+", "+Codewords{i}.set+Codewords{i}.ID;
end
Actual=erase(I2(1).name,["_test",".wav"]);
for i=2:length(I2)
    Actual=Actual+", "+erase(I2(i).name,["_test",".wav"]);
end
% Print the results!
disp(TestResults)
disp(Actual)