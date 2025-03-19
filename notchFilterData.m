function notchFilterData(inputDir, outputDir, notchF, notchQuality)
    % This function will perform the notch filtering of the data in
    % Test_Data and will convert the notch-filtered test data to .wav files
    % and store them in their own new directory

    % Create the output directory if it does not already exist
    if ~exist(outputDir,"dir")
        mkdir(outputDir)
    end

    % Obtain the test data files
    I3=dir(fullfile(inputDir, 's*.wav'));

    % For all test data files
    for i=1:length(I3)
        % Read in the current audio file
        [x, Fs] = audioread(fullfile(I3(i).folder, I3(i).name));

        % Normalize the notch frequency
        W0 = notchF / (Fs/2);

        % Design the notch filter
        notchfilter = designNotchPeakIIR('notch', 'Frequency', notchF, 'SampleRate', Fs, 'Q', notchQuality);

        % Apply the filter to the audio file
        xFiltered = filter(notchfilter, x);

        % Obtain the file path for the filtered audio file
        filepath = fullfile(OutputDir, I3(i).name);

        % Save the filtered audio file
        audiowrite(filepath, xFiltered, Fs);
    end
end