# EEC 201 Final Project - Kokott and Shaik
Hello! Welcome to our final project repository!

(This README describes how to run our project code and briefly describes our project results at the very end. For a more in-depth discussion of our approaches, tests, results, and efforts in this project, please see the file in this repository entitled "EEC 201 Final Project Report - Kokott and Shaik.pdf.")

To get started:
1. Please download all of the .m files in this repository along with the Test_Data and Training_Data folders.
2. Please ensure that all of the .m files as well as the Test_Data and Training_Data folders are all in one directory on your machine.
3. Please open the ProjectTraining1.m file in MATLAB.
4. Run this file in order to train the model on the speakers in the training data folder and to test the model's ability to recognize the speakers in the test data folder.
5. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the training data folder as well as the MFCC plot for the training data, please change the operator "false" in the MFCC function call in line 26 of ProjectTraining1.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)
6. If you would like to see the Vector Quantization codeword plots for all speakers in the training data folder, please change the operator "false" in the LBGTraining function call in line 28 of ProjectTraining1.m to "true." This will set the showFigures parameter in our LBGTraining.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)
7. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the test data folder as well as the MFCC plot for the test data, please change the operator "false" in the MFCC function call in line 40 of ProjectTraining1.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)


To run the MFCC code on one .wav file:  
Call the function MFCC(filename, N, M, K, showFigures)  
1. filename is the path to the .wav file  
2. N is the size of the frame  
3. M is the distance between frame starts  
4. K is the number of Mel-frequency bins  
5. showFigures is a binary variable that toggles graphs (so that dozens of figures aren't opened when this is included in ProjectTraining1.m)

The output of the MFCC function is a matrix, where each column represents a vector of dimension K-1, whose entries are the MFCC


To run the LBGTraining code on data from one .wav file:  
Call the function LBGTraining(inputs, Iterations, e, E, dim1, dim2, showFigures)  
1. inputs is the MFCC matrix obtained by calling MFCC
2. Iterations defines the size of the codebook as 2^Iterations; aka this is the number of loops made
3. e is the small factor by which the codewords are varied during the splitting process
4. E is the maximum change in distortion for which the function will begin the next loop
5. dim1 is the first dimension the vectors are plotted with
6. dim2 is the second dimension the vectors are plotted with
7. showFigures is a binary variable that toggles graphs (so that dozens of figures aren't opened when this is included in ProjectTraining1.m)

The output of the LBGTraining function is a matrix, where each column represents a vector of dimension K-1. Each of these vectors is one of the codewords for this .wav file

Brief Discussion of Results:
When running ProjectTraining1.m on the original, default Training_Data and Test_Data, our model was successfully able to identify all 8 of the speakers in the Test_Data folder. Thus, for the default dataset, our model was 100% accurate.
