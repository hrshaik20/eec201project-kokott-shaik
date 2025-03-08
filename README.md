# EEC 201 Final Project - Kokott and Shaik
Hello! Welcome to our final project repository!

To get started:
1. Please download all of the .m files in this repository along with the Test_Data and Training_Data folders.
2. Please ensure that all of the .m files as well as the Test_Data and Training_Data folders are all in one directory on your machine.
3. Please open the ProjectTraining1.m file in MATLAB.
4. Run this file in order to train the model on the speakers in the training data folder and to test the model's ability to recognize the speakers in the test data folder.
5. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the training data folder as well as the MFCC plot for the training data, please change the operator "false" in the MFCC function call in line 26 of ProjectTraining1.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots.
6. If you would like to see the Vector Quantization codeword plots for all speakers in the training data folder, please change the operator "false" in the LBGTraining function call in line 28 of ProjectTraining1.m to "true." This will set the showFigures parameter in our LBGTraining.m function to true, generating the desired plots.
7. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the test data folder as well as the MFCC plot for the test data, please change the operator "false" in the MFCC function call in line 40 of ProjectTraining1.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots.

To run the MFCC code on one .wav file:
Call the function MFCC(filename, N, M, K, showFigures)
  filename is the path to the .wav file
  N is the size of the frame
  M is the distance between frame starts
  K is the number of Mel-frequency bins
  showFigures is a binary variable that toggles graphs (so that hundreds of figures aren't opened when this is included in ProjectTraining1.m)
The output of the function is a matrix, where each column represents a vector of dimension K-1, whose entries are the MFCC

To run the LBGTraining code on data from one .wav file:
Call the function LBGTraining(inputs, Iterations, e, E, dim1, dim2, showFigures)
  inputs is the MFCC matrix obtained by calling MFCC
  Iterations defines the size of the codebook as 2^Iterations; aka this is the number of loops made
  e is the small factor by which the codewords are varied during the splitting process
  E is the maximum change in distortion for which the function will begin the next loop
  dim1 is the first dimension the vectors are plotted with
  dim2 is the second dimension the vectors are plotted with
  showFigures is a binary variable that toggles graphs (so that dozens of figures aren't opened when this is included in ProjectTraining1.m)
The output of the function is a matrix, where each column represents a vector of dimension K-1. Each of these vectors is one of the codewords for this .wav file
