% Design an integral controller for the following state space model

format long
%%%%%%
% State Space Model
%%%%%%

A = [0, 1; 
     0, 0;];

B = [1, 0; 
     0, 1;];

B_w = [1;
       0;];

B_r = eye(2,2);

C = [1, 0; 
     0, 1;];

% Number of states n and inputs m and outputs p
n = size(A, 2);
m = size(B, 2);
p = size(C,1);

%%%%%%
% Check controllability and that the 
% rank of [A, B; C, 0;] == n + m
%%%%%%

% Form controllability matrix W_c and check it's rank
W_c = [];
for i = 0:n-1
    W_c = horzcat(W_c, (A^i)*B);
end
disp("Controllability Matrix: ")
disp(W_c)
fprintf("Rank of controllability matrix: %d \n", rank(W_c))
% Since controllability matrix is 2 (full rank). Hence all states are
% controllable.

% Check that rank of [A, B; C, 0;] == n + m
if (rank([A, B; C, zeros(2,2);]) == (n + m))
    fprintf("[A, B; C, 0;] matrix is full rank at %d\n", rank([A, B; C, zeros(2,2);]))
else
    fprintf("[A, B; C, 0;] matrix is not full rank at %d\n", rank([A, B; C, zeros(2,2);]))
end 

%%%%%%
% Form augmented system
%%%%%%

A_bar = [A,  zeros(n, m);
         -C, zeros(m, m);];

B_bar = [B;
         zeros(m, m);]

B_w_bar = [B_w;
           zeros(m,1);]

B_r_bar = [zeros(n,m);
           eye(m,m);];

C_bar = [C, zeros(p,m);];

%%%%%%
% We use LQR to stabilize the augmented system
%%%%%%

% We want to minimize J = integral(x_bar.T * Q * x_bar + u.T * R * u) with respect to dt
% First we solve the algebraic riccati equation to obtain the gain matrix

Q = eye(n+m,n+m);
R = eye(m,m);

[X,K,L] = icare(A_bar,B_bar,Q,R,[],[],[])

% Obtain gain matrices K1 and K2 from the LQR gain matrix
% K1 = K(:, 1:n);
% K2 = K(:, n+1:end);

