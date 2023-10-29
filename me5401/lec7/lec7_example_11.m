% State Space Model

% State(or system) matrix
A = [0 0 4 1;
     10 13 2 8;
     -3 -3 0 -2;
     -10 -14 -5 -9];

% Input matrix
B = [-2 0;
     4 -3;
     -1 1;
     -3 3;];


% Number of states n
n = size(A, 2);
m = size(B, 2);

% Check eigenvalues of open loop system matrix
A_eigenvalues = eig(A);
disp("Open loop eigenvalues (A): ")
disp(A_eigenvalues)


% % Get Dominant/Slow poles
des_pole_1 = -1/2 + 1i*(sqrt(3)/2);
des_pole_2 = conj(des_pole_1);
% Get Fast poles, they have to be far away from dominant one (2-5 times faster)
des_pole_3 = -2;
des_pole_4 = -3;

des_poles = [des_pole_1 des_pole_2 des_pole_3 des_pole_4];
disp("Desired poles: ")
disp(des_poles)

% We get our desired closed loop polynomial
syms s;
closed_loop_des_poly = (s-des_poles(1)) * (s-des_poles(2)) * (s-des_poles(3)) * (s-des_poles(4));
fprintf("Closed loop desired polynomial: %s \n", expand(closed_loop_des_poly));

%%%%%%%%%
% Check controllability
%%%%%%%%%
% Form controllability matrix W_c and check it's rank
W_c = [];
for i = 0:n-1
    W_c = horzcat(W_c, (A^i)*B);
end
disp("Controllability Matrix: ")
disp(W_c)
fprintf("Rank of controllability matrix: %d \n", rank(W_c))
% Since controllability matrix is 4 (full rank). Hence all states are
% controllable.

%%%%%%%%%
% Obtain controllable canonical form
%%%%%%%%%
% Use reduced row echelon form algorithm to get n linearly indepenent
% columns from left to right
[R, pivots] = rref(W_c);
disp("pivots selected for linearly independent vectors of W_c: ")
disp(pivots)

% We select b1, b2, A*b1, A*b2, 
% Regroup the m as b1,  A*b1, b2, A*b2, 
C_ctrl = W_c(:, [1, 3, 2, 4]);
C_ctrl_inv = inv(C_ctrl);

disp("C matrix (Control): ")
disp(C_ctrl)
disp("C inverse matrix (Control): ")
disp(C_ctrl_inv)

% To get transformation matrix T, for each input, one row is taken out to 
% construct T.
% We have 2 inputs, so we take out d1=1 and d1+d2=3
d1 = 2;
d2 = 2;

q2_T = C_ctrl_inv(d1, :);
q4_T = C_ctrl_inv(d1+d2, :);

% Finally, we obtain transformation matrix T
T = [q2_T; 
     q2_T * A; 
     q4_T; 
     q4_T * A;];

T_inv = inv(T);

% From Transformation matrix T, we obtain the controllable canonical form
A_bar = rmv_eps(T * A * T_inv);
B_bar = rmv_eps(T * B);

disp("A_bar: ")
disp(A_bar)

disp("B_bar: ")
disp(B_bar)

% There are 2 inputs and hence 2 non-trivial rows
% We can design the feedback gain matrix as follow

% We create K as a symbolic matrix
K_bar = sym('K_bar', [m,n]);

% Form closed loop system matrix
A_cl = A_bar - B_bar * K_bar;
disp("A_cl (Closed loop)")
disp(A_cl)

%%%%%%%%%
% Get gain matrix K
%%%%%%%%%
% From closed loop desired polynomial: s^4 + 6*s^3 + 12*s^2 + 11*s  + 6 
% Construct the desired closed loop matrix

A_cl_des = [0               1               0            0; ...
            0               0               1            0; ...
            0               0               0            1; ...
           -6     -11    -12    -6;];


% Compare desired polynomial and closed loop polynomial to get values of
% gain matrix of K_bar
K_bar_eqn = A_cl_des == A_cl;
K_bar_soln = solve(K_bar_eqn, symvar(K_bar));
K_bar = subs(K_bar, K_bar_soln)

% Get gain matrix K
K = K_bar * T;

disp("Gain matrix K: ");
disp(K);

% Remove small values below a certain threshold
function M = rmv_eps(M)
    M(abs(M)<1e-5)=0;
end



