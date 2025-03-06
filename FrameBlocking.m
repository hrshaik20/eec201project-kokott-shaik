function Output = FrameBlocking (Data,N,M)
    %Example: length(Data)=1000, N=256, M=100: We want blocks 1:256,
    %101:356, 201:456, 301:556, 401:656, 501:756, 601:856, 701:956,
    %1000-N+1:1000
    for i=0:floor((length(Data)-N)/M)
        Output(1:N,i+1)=Data(i*M+1:i*M+N)';
    end
    %Output(1:N,end+1)=Data(length(Data)-N+1:length(Data))';
    temp=Data(floor((length(Data)-N)/M+1)*M+1:end);
    temp(N)=0;
    Output(1:N,end+1)=temp';
end