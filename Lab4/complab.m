A = [6, 15, 55; 5, 55, 225; 55, 225, 979]; 

[L, U, P] = lu(A); 

B = eye(3); 

A_inv = zeros(3, 3);

for i = 1:3
    % Get the i-th column of the identity matrix 
    b_i = B(:, i);
    
    % Doing both forward and backward sub
    Pb = P * b_i;
    y = L \ Pb;
    x = U \ y;
    
    A_inv(:, i) = x;
end

% 5. Display Labeled Results
disp('A');
disp(A);

disp('A_inv');
disp(A_inv);


Identity_Check = A * A_inv;

disp('Verification');
disp(Identity_Check);
