
% State Space Model
format shortEng

% State(or system) matrix
A = [-1, 1, 0; ...
     0,  1, 1; ...
     0,  0, 2;];

B = [1, 1; ...
     0, 0; ...
     0, 1;];

C = [1, 3, -1;...
     0, 1,  0;];

% Number of states n
n = size(A, 2);
m = size(B, 2);

% Original open loop System
sys = ss(A, B, C, 0);

% Check eigenvalues of open loop system matrix
A_eigenvalues = eig(A);
disp("Open loop eigenvalues (A): ")
disp(A_eigenvalues)

% Open loop eigen values are -1, 1, and 2

%%%%%%%%%
% Check controllability and obtain controllable canonical form
%%%%%%%%%
ctrb_mat = ctrb(A,B);
disp("Rank of controllability matrix: ")
disp(rank(ctrb_mat))

% For MIMO system, need to select n independent vectors out of nm vectors from 
% controllability matrix in strict order from left to right
W_c = [];
for i = 0:n-1
    W_c = horzcat(W_c, (A^i)*B);
end

% Use reduced row echelon form algorithm to get n linearly indepenent
% columns from left to right
[R, pivots] = rref(W_c);
C_ctrl = W_c(:, pivots(1:n));

C_ctrl_inv = inv(C_ctrl)

% To get transformation matrix T, for each input, one row is taken out to 
% construct T.
% We have 2 inputs, 
d1 = 1;
d2 = 2;

% we take out d1=1 and d1+d2=3
q1_T = C_ctrl_inv(d1, :);
q3_T = C_ctrl_inv(d1+d2, :);

% Finally, we obtain transformation matrix T
T = [q1_T; q3_T; q3_T*A;];
T_inv = inv(T);

% From Transformation matrix T, we obtain the controllable canonical form
A_bar = T * A * T_inv;
B_bar = T * B;

% There are 2 inputs and hence 2 non-trivial rows
% We can design the feedback gain matrix as follow

% We create K as a symbolic matrix
K_bar = sym('K_bar', [m,n]);

% Form closed loop system matrix
A_cl = A_bar - B_bar * K_bar;
disp("A_cl (Closed loop)")
disp(A_cl)

% Now we determine our desired eigenvalues and use it to construct a
% possible desired closed loop matrix
des_eigenval = [-1, -2, -3];

% We represent the equation as a combination of a 1st order and 2nd order
% system
sym s;
des_polynomial_eqn = (s-des_eigenval(1)) * expand((s-des_eigenval(2)) * (s-des_eigenval(3)));
fprintf("Desired polynomial equation: %s \n", char(des_polynomial_eqn))

% We can construct the desired closed loop matrix as follows
A_d = [-1, 0, 0;
       0, 0, 1;
       0, -6, -5;];

K_bar_eqn = A_cl == A_d;
K_bar_soln = solve(K_bar_eqn);
K_bar = subs(K_bar, K_bar_soln);

% Get gain matrix K
K = K_bar * T;

