
A = [0, 2; 0, 1];

[L, U, P] = lu(A);

% Display the results
disp('L:')
disp(L)

disp('U')
disp(U)

disp('P')
disp(P)


disp('Verification (P*A - L*U):')
disp(P*A - L*U)
