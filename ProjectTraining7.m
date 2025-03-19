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
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    index=str2double(erase(I_twelve(i).name,[".wav","Twelve_train"]));
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data_twelve{index}=MFCC(I_twelve(i).folder+"\"+I_twelve(i).name,N,M,K_twelve,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords_twelve{index}=LBGTraining(data_twelve{index},NumIterations_twelve,0.01,0.01,1,2,false);
end

% For each training data file:
for i=1:length(I_zero)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index, since "I" may return s1, s10, s11, s2... instead of
    % s1, s2, s3, s4...
    index=str2double(erase(I_zero(i).name,[".wav","Zero_train"]));
    % Obtain the MFCC data from the i-th speaker, and store it in
    % their proper index
    data_zero{index}=MFCC(I_zero(i).folder+"\"+I_zero(i).name,N,M,K_zero,false);
    % Using the LBG training algorithm, generate 2^NumIterations codewords
    Codewords_zero{index}=LBGTraining(data_zero{index},NumIterations_zero,0.01,0.01,1,2,false);
end

% Get the test data filepaths
I2_twelve=dir("Twelve-Testing\Twelve_test*.wav");
I2_zero=dir("Zero-Testing\Zero_test*.wav");
% For each test data file:
for i=1:length(I2_twelve)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index (see above)
    index=str2double(erase(I2_twelve(i).name,[".wav","Twelve_test"]));
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2_twelve{index}=MFCC(I2_twelve(i).folder+"\"+I2_twelve(i).name,N,M,K_twelve,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords_twelve)
        Distances_twelve{index,n}=disteu(Codewords_twelve{n},data2_twelve{index});
        Distances_zero{index,n}=disteu(Codewords_zero{n},data2_twelve{index});
        Distortion_twelve(n)=sum(min(Distances_twelve{index,n},[],1));
        Distortion_zero(n)=sum(min(Distances_zero{index,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist_twelve(index),speakerID_twelve(index)]=min(Distortion_twelve);
    % Identify the spoken word
    [WordDist_twelve(index), wordID_twelve(index)] = min([Distortion_twelve(speakerID_twelve(index)), Distortion_zero(speakerID_twelve(index))]);

    if wordID_twelve(index) == 1
        wordPrediction_twelve{index} = "Twelve";
    else
        wordPrediction_twelve{index} = "Zero";
    end
end

% For each test data file:
for i=1:length(I2_zero)
    % Make sure the index we assign each speaker to is actually the
    % speaker's index (see above)
    index=str2double(erase(I2_zero(i).name,[".wav","Zero_test"]));
    % Obtain the MFCC data from the i-th speaker, and store it in their
    % proper index (not used to calculate the speakerID variable)
    data2_zero{index}=MFCC(I2_zero(i).folder+"\"+I2_zero(i).name,N,M,K_zero,false);
    % Compare minimum distortions from each codebook
    for n=1:length(Codewords_zero)
        Distances_twelve{index,n}=disteu(Codewords_twelve{n},data2_zero{index});
        Distances_zero{index,n}=disteu(Codewords_zero{n},data2_zero{index});
        Distortion_twelve(n)=sum(min(Distances_twelve{index,n},[],1));
        Distortion_zero(n)=sum(min(Distances_zero{index,n},[],1));
    end
    % Select the minimum distortion, and since we defined the Codewords
    % index to match the speakerID, we can use the index of the minimum
    % distortion as our speakerID. Then, assign this minimum to the index
    % calculated at the start of the loop (aka, the true value of
    % speakerID)
    [MinDist_zero(index),speakerID_zero(index)]=min(Distortion_zero);
    % Identify the spoken word
    [WordDist_zero(index), wordID_zero(index)] = min([Distortion_twelve(speakerID_zero(index)), Distortion_zero(speakerID_zero(index))]);

    if wordID_zero(index) == 1
        wordPrediction_zero{index} = "Twelve";
    else
        wordPrediction_zero{index} = "Zero";
    end
end
% Print the results!
for i = 1:length(speakerID_twelve)
    fprintf("Speaker %d: Identified as saying %s\n", speakerID_twelve(i), wordPrediction_twelve{i});
end
for i = 1:length(speakerID_zero)
    fprintf("Speaker %d: Identified as saying %s\n", speakerID_zero(i), wordPrediction_zero{i});
end