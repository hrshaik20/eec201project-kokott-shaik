# EEC 201 Final Project - Kokott and Shaik
Hello! Welcome to our final project repository!

(This README describes how to run our project code and briefly describes our project results at the very end. For a more in-depth discussion of our approaches, tests, results, and efforts in this project, please see the file in this repository entitled "EEC 201 Final Project Report - Kokott and Shaik.pdf.")

To get started:
1. Please download all of the .m files in this repository along with all of the folders as these folders contain the training and testing datasets.
2. Please ensure that all of the .m files as well as the data folders are all in one directory on your machine.
3. Please open the ProjectTraining1.m file in MATLAB.
4. Run this file in order to train the model on the speakers in the Training_Data folder and to test the model's ability to recognize the speakers in the Test_Data folder.
5. Please open the ProjectTraining2.m file in MATLAB.
6. Run this file in order to train the model on the speakers in the Twelve-Training folder and to test the model's ability to recognize the speakers in the Twelve-Testing folder.
7. Please open the ProjectTraining3.m file in MATLAB.
8. Run this file in order to train the model on the speakers in the Zero-Training folder and to test the model's ability to recognize the speakers in the Zero-Testing folder.
9. Please open the ProjectTraining4.m file in MATLAB.
10. Run this file in order to train the model on the speakers in the Eleven Training folder and to test the model's ability to recognize the speakers in the Eleven Test folder.
11. Please open the ProjectTraining5.m file in MATLAB.
12. Run this file in order to train the model on the speakers in the Five Training folder and to test the model's ability to recognize the speakers in the Five Test folder.
13. Please open the ProjectTraining6.m file in MATLAB.
14. Run this file in order to train the model on the speakers in the Training_Data folder. This file will also generate the notch-filtered test data folder (Filtered_Test_Data) for you or you can comment out line 34 of this file and directly utilize the Filtered_Test_Data folder provided in this repository. The model's ability to recognize the speakers in the Filtered_Test_Data folder will then be tested.
15. Please open the ProjectTraining7.m file in MATLAB.
16. Run this file in order to train the model on both the Twelve-Training and Zero-Training folders and to test the model's ability to recognize the speakers in the Twelve-Testing and Zero-Testing folders as well as to test the model's ability to recognize the spoken word in these audio files as either "twelve" or "zero."
17. Please open the ProjectTrainingTests2.m file in MATLAB.
18. Run this file if you would like to see an alternative to ProjectTraining7.m in which the model is trained on the training data present in 2024StudentAudioRecordings (the original Twelve-Training and Zero-Training data folders that did not rename the speakers) and is tested on the testing data present in 2024StudentAudioRecordings (the original Twelve-Testing and Zero-Testing data folders that did not rename the speakers).
19. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the training data folder as well as the MFCC plot for the training data, please change the operator "false" in the MFCC function call in line 27 of ProjectTrainingX.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)
20. If you would like to see the Vector Quantization codeword plots for all speakers in the training data folder, please change the operator "false" in the LBGTraining function call in line 29 of ProjectTrainingX.m to "true." This will set the showFigures parameter in our LBGTraining.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)
21. If you would like to see the plots of the speech signals, the mel-spaced filterbank responses, the power spectrum before mel-wrapping, and the power spectrum after mel-wrapping for all speakers in the test data folder as well as the MFCC plot for the test data, please change the operator "false" in the MFCC function call in line 41 of ProjectTrainingX.m to "true." This will set the showFigures parameter in our MFCC.m function to true, generating the desired plots. (WARNING: This will generate dozens of figures)


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

When running ProjectTraining1.m on the original, default Training_Data and Test_Data folders, our model was successfully able to identify all 8 of the speakers in the Test_Data folder. **Thus, for the default dataset, our model was 100% accurate.** ProjectTraining1.m also attained 100% accuracy when the default dataset was augmented with training and testing data from Kaleb and his sister as well as with 10 of the speakers from the Zero-Testing and Zero-Training datasets.

When running ProjectTraining2.m on the Twelve-Training and Twelve-Testing folders, our model was succesfully able to identify all 18 of the speakers in the Twelve-Testing folder. **Thus, for the twelve dataset, our model was 100% accurate.**

When running ProjectTraining3.m on the Zero-Training and Zero-Testing folders, our model was successfully able to identify all but 1 of the speakers in the Zero-Testing folder, i.e., 17 of the 18 speakers. **Thus, for the zero dataset, our model was about 94% accurate.**

When running ProjectTraining4.m on the Eleven Training and Eleven Test folders, our model was successfully able to identify all 23 speakers in the Eleven Test folder. **Thus, for the eleven dataset, our model was 100% accurate.**

When running ProjectTraining5.m on the Five Training and Five Test folders, our model was successfully able to identify all 23 speakers in the Five Test folder. **Thus, for the five dataset, our model was 100% accurate.**

When running ProjectTraining6.m on the original, default Training_Data and the Filtered_Test_Data folders, our model was successfully able to identify all 18 of the speakers in the Filtered_Test_Data folder. **Thus, for the notch-filtered dataset, our model was 100% accurate.**

When running ProjectTraining7.m on the Twelve-Training, Zero-Training, Twelve-Testing, and Zero-Testing folders, our model correctly identified 35 of the 36 testing audio files as their correct speaker and was able to successfully identify the spoken word for all 36 audio files. **Thus, in terms of identifying the speakers, our model was about 97% accurate here and was 100% accurate in identifying the spoken word.**

When running ProjectTrainingTests2.m on the 2024StudentAudioRecording folder containing the original Twelve-Training, Zero-Training, Twelve-Testing, and Zero-Testing folders that did not rename the speakers, our model correctly identified 34 of the 36 testing audio files as their correct speaker. **Thus, our model was about 94% accurate for this case.**
