function Output = Window (Input)
    % First, make the array the window is based off of
    n=0:size(Input,1)-1;
    % Calculate the magnitudes for the Hamming Window specified in the
    % project slides
    w=0.54-0.46*cos(2*pi*n/(size(Input,1)-1));
    % Elementwise multiply the frame value by the window value, and return
    % the result.
    Output=Input.*w';
end