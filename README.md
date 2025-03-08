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
