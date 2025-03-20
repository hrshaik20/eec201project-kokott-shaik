% 2024 students' twelve training and testing
close all
clear
% Get the training data filepaths
I_twelve=dir("Twelve-Training\Twelve_train*.wav");
I_zero=dir("Zero-Training\Zero_train*.wav");
% Elements per frame. 512 is sufficient for the 18/18 speakers in the
% training/testing datasets.
N=512;
% Distance between frame starts. 200 is sufficient for the 18/18 speakers in
% the training/testing datasets.
M=200;
% MFCC bins produced. 35 is sufficient for the 18/18 speakers in the
% training/testing datasets and provided the desired 100% accuracy.
% Different K for each dataset
K_twelve=35;
K_zero = 35;
% How many codewords to generate in the LBG algorithm, 2^NumIterations. 4
% is sufficient with the other settings for the 18/18 speakers in the
% training/testing datasets and provided the desired 100% accuracy.
% Different number of iterations for each dataset
NumIterations_twelve=4;
NumIterations_zero = 4;
% For each training data file:
for i=1:length(I_twelve)
    Codewords_twelve{i}.ID=str2double(erase(I_twelve(i).name,[".wav","Twelve_train"]));
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data_twelve{i}=MFCC(I_twelve(i).folder+"\"+I_twelve(i).name,N,M,K_twelve,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords_twelve{i}.value=LBGTraining(data_twelve{i},NumIterations_twelve,0.01,0.01,1,2,false);
end

% For each training data file:
for i=1:length(I_zero)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    Codewords_zero{i}.ID=str2double(erase(I_zero(i).name,[".wav","Zero_train"]));
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data_zero{i}=MFCC(I_zero(i).folder+"\"+I_zero(i).name,N,M,K_zero,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords_zero{i}.value=LBGTraining(data_zero{i},NumIterations_zero,0.01,0.01,1,2,false);
end

% Get the test data filepaths
I2_twelve=dir("Twelve-Testing\Twelve_test*.wav");
I2_zero=dir("Zero-Testing\Zero_test*.wav");
% For each test data file:
for i=1:length(I2_twelve)
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2_twelve{i}=MFCC(I2_twelve(i).folder+"\"+I2_twelve(i).name,N,M,K_twelve,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords_twelve)
        Distances_twelve{i,n}=disteu(Codewords_twelve{n}.value,data2_twelve{i});
        Distances_zero{i,n}=disteu(Codewords_zero{n}.value,data2_twelve{i});
        Distortion_twelve(n)=sum(min(Distances_twelve{i,n},[],1));
        Distortion_zero(n)=sum(min(Distances_zero{i,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist_twelve(i),speakerID_twelve(i)]=min(Distortion_twelve);
    % Identify the spoken word
    [WordDist_twelve(i), wordID_twelve(i)] = min([Distortion_twelve(speakerID_twelve(i)), Distortion_zero(speakerID_twelve(i))]);

    if wordID_twelve(i) == 1
        wordPrediction_twelve{i} = "Twelve";
    else
        wordPrediction_twelve{i} = "Zero";
    end
end

% For each test data file:
for i=1:length(I2_zero)
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2_zero{i}=MFCC(I2_zero(i).folder+"\"+I2_zero(i).name,N,M,K_zero,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords_zero)
        Distances_twelve{i,n}=disteu(Codewords_twelve{n}.value,data2_zero{i});
        Distances_zero{i,n}=disteu(Codewords_zero{n}.value,data2_zero{i});
        Distortion_twelve(n)=sum(min(Distances_twelve{i,n},[],1));
        Distortion_zero(n)=sum(min(Distances_zero{i,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist_zero(i),speakerID_zero(i)]=min(Distortion_zero);
    % Identify the spoken word
    [WordDist_zero(i), wordID_zero(i)] = min([Distortion_twelve(speakerID_zero(i)), Distortion_zero(speakerID_zero(i))]);

    if wordID_zero(i) == 1
        wordPrediction_zero{i} = "Twelve";
    else
        wordPrediction_zero{i} = "Zero";
    end
end
% Print the results!
TestResults=[];
Actual=[];
for i = 1:length(speakerID_twelve)
    fprintf("Speaker %d: Identified as saying %s\n", speakerID_twelve(i), wordPrediction_twelve{i});
    if wordID_twelve(i)<2
        TestResults=[TestResults,"Twelve_"+string(Codewords_twelve{speakerID_twelve(i)}.ID)];
    else
        TestResults=[TestResults,"Zero_"+string(Codewords_zero{speakerID_twelve(i)}.ID)];
    end
    Actual=[Actual,string(erase(I2_twelve(i).name,["test",".wav"]))];
end
for i = 1:length(speakerID_zero)
    fprintf("Speaker %d: Identified as saying %s\n", speakerID_zero(i), wordPrediction_zero{i});
    if wordID_zero(i)<2
        TestResults=[TestResults,"Twelve_"+string(Codewords_twelve{speakerID_zero(i)}.ID)];
    else
        TestResults=[TestResults,"Zero_"+string(Codewords_zero{speakerID_zero(i)}.ID)];
    end
    Actual=[Actual,string(erase(I2_zero(i).name,["test",".wav"]))];
end
Accuracy=sum(TestResults==Actual)/length(TestResults);
disp("Actually: "+Actual(TestResults~=Actual))
disp("Misidendified as: "+TestResults(TestResults~=Actual))
disp("Accuracy is "+(Accuracy*100)+"%")