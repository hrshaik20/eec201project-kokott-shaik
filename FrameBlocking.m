function Output = FrameBlocking (Data,N,M)
    % Read our data in blocks of size N, stepping up by M each time. Zero
    % pad the results if they are less than N
    for i=0:floor((length(Data))/M)
        Output(1:N,i+1)=[[Data((i*M+1):min(i*M+N,length(Data)))];zeros([N-size(i*M+1:min(i*M+N,length(Data)),2),1])];
    end
    % Remove frames that are equal to 0 throughout their time period
    % (causes problems with Test_Data\s8.wav if not addressed)
    Output=Output(:,sum(abs(Output),1)~=0);
end