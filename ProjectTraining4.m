% 2025 students' eleven training and testing
close all
clear
% Get the training data filepaths
I=dir("Eleven Training\s*.wav");
% Elements per frame. 512 is sufficient for the 23/23 speakers in the
% training/testing datasets.
N=512;
% Distance between frame starts. 200 is sufficient for the 23/23 speakers in
% the training/testing datasets.
M=200;
% MFCC bins produced. 20 is sufficient for the 23/23 speakers in the
% training/testing datasets.
K=20;
% How many codewords to generate in the LBG algorithm, 2^NumIterations. 3
% is sufficient with the other settings for the 23/23 speakers in the
% training/testing datasets.
NumIterations=3;
% For each training data file:
for i=1:length(I)
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data{i}=MFCC(I(i).folder+"\"+I(i).name,N,M,K,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords{i}.value=LBGTraining(data{i},NumIterations,0.01,0.01,1,2,false);
    Codewords{i}.ID=erase(I(i).name,[".wav","s"]);
end

% Get the test data filepaths
I2=dir("Eleven Test\s*.wav");
% For each test data file:
for i=1:length(I2)
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
% Print the results!
TestResults=[string(Codewords{speakerID(1)}.ID)];
for i=2:length(speakerID)
    TestResults=[TestResults, string(Codewords{speakerID(i)}.ID)];
end
Actual=[string(erase(I2(1).name,["s",".wav"]))];
for i=2:length(I2)
    Actual=[Actual, string(erase(I2(i).name,["s",".wav"]))];
end
Accuracy=sum(TestResults==Actual)/length(TestResults);
disp("Actually: "+Actual(TestResults~=Actual))
disp("Misidendified as: "+TestResults(TestResults~=Actual))
disp("Accuracy is "+(Accuracy*100)+"%")