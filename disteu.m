function d = disteu(x, y)
% DISTEU Pairwise Euclidean distances between columns of two matrices
%
% Input:
%       x, y:   Two matrices whose each column is an a vector data.
%
% Output:
%       d:      Element d(i,j) will be the Euclidean distance between two
%               column vectors X(:,i) and Y(:,j)
%
% Note:
%       The Euclidean distance D between two vectors X and Y is:
%       D = sum((x-y).^2).^0.5

% This line stores the number of rows M and columns N in matrix x
[M, N] = size(x);
% This line stores the number of rows M2 and columns P in matrix y
[M2, P] = size(y); 

% Here, the function checks if both matrices have the same number of rows
if (M ~= M2)
% If the number of rows in both matrics are not equal, an error is thrown
% stating that the dimensions do not match
    error('Matrix dimensions do not match.')
end

% The function output d is initialized to be an N x P matrix of all zeros
d = zeros(N, P);

% If N is less than P, the following actions are performed
if (N < P)
% The vector copies is initalized as an all-zero vector of size 1 x P
    copies = zeros(1,P);
    % The for loop cycles through indices 1 through N
    for n = 1:N
    % This line calculates the sum inside the square root in the Euclidean distance formula
        d(n,:) = sum((x(:, n+copies) - y) .^2, 1);
    end
else
% If P is less than N, the vector copies is initialized as an all-zero vector of size 1 x N
    copies = zeros(1,N);
    % The for loop cycles through indices 1 through P
    for p = 1:P
    % The sum inside the square root in the Euclidean distance formula is calculated
        d(:,p) = sum((x - y(:, p+copies)) .^2, 1)';
    end
end

% The square root of the previously calculated sum is taken to obtain the Euclidean distance
d = d.^0.5;
