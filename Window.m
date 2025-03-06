function Output = Window (Input)
    n=0:size(Input,1)-1;
    w=0.54-0.46*cos(2*pi*n/(size(Input,1)-1));
    Output=Input.*w';
end