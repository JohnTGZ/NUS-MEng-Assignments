format long
%%%%%%
% State Space Model
%%%%%%

%Arbitrary params
% X_dot = A * X + B * U
% Y = C * X
[a, b, c, d] = deal(4, 9, 1, 2);

% State(or system) matrix
A = [-8.8487 + (a-b)/5,     -0.0399,              -5.55 + (c+d)/10,      3.5846; 
     -4.5740,               2.5010 * (d+5)/(c+5), -4.3662,               -1.1183-(a-c)/20; 
     3.7698,                16.1212 - (c/5),      -18.2103+(a+d)/(b+4),  4.4936; 
     -8.5645-(a-b)/(c+d+2), 8.3742,               -4.4331,               -7.7181*(c+5)/(b+5);];

% Input matrix
B = [0.0564+(b)/(10+c),           0.0319; 
     0.0165-(c+d-5)/(1000+20*a),  -0.02; 
     4.4939,                      1.5985*(a+10)/(b+12); 
     -1.4269,                     -0.2730;];

% Output matrix
C = [-3.2988,           -2.1932+(10*c+d)/(100+5*a), 0.0370,  -0.0109; 
     0.2922-(a*b)/500,  -2.1506,                   -0.0104,   0.0163;];

D = [0, 0; 
     0, 0;];

x_0 = [0.5; -0.1; 0.3; -0.8;];

u_1 = [1; 0;];
u_2 = [0; 1;];

% Number of states n
n = size(A, 2);
m = size(B, 2);

% Check eigenvalues of open loop system matrix
% A_eigenvalues = eig(A);
% disp("Open loop eigenvalues (A): ")
% disp(A_eigenvalues)

% Open loop eigen values are:
% 1) -12.0330e+000 +  8.0747e+000i
% 2) -12.0330e+000 -  8.0747e+000i
% 3) -1.9607e+000 +  3.8055e+000i
% 4) -1.9607e+000 -  3.8055e+000i

% This is a stable system (Elaborate) 

%%%%%%%%%
% Determine desired eigenvalues
%%%%%%%%%
% Design requirements:
% 1) Overshoot (M_p) less than 10%
% 2) 2% settling time (t_s) less than 20 seconds

% Damping ratio: xi > 0.5913123
% Natural frequency: om*xi > 0.2

% We shall choose the following values:
% xi = 0.6;
% From om > 0.2/0.6, we choose om = 0.4;
xi = 0.6;
om = 0.4;

% Although system is 4th order, we can approximate the system as a second
% order system. This is because the system's response is dominated by the
% slow mode.

% % Get Dominant/Slow poles
des_pole_1 = - xi * om + 1i*(om*sqrt(1-xi^2));
des_pole_2 = conj(des_pole_1);
% Get Fast poles, they have to be far away from dominant one (2-5 times faster)
des_pole_3 = real(des_pole_1)*3;
des_pole_4 = real(des_pole_1)*4;

des_poles = [des_pole_1 des_pole_2 des_pole_3 des_pole_4];
% disp("Desired poles: ")
% disp(des_poles)

% We get our desired closed loop polynomial
syms s;
% closed_loop_des_poly = vpa((s^2 + 2*xi*om*s + om^2) * (s-des_poles(3)) * (s-des_poles(4)));
closed_loop_des_poly = ((s^2 + 2*xi*om*s + om^2) * (s-des_poles(3)) * (s-des_poles(4)));
% fprintf("Closed loop desired polynomial: %s \n", closed_loop_des_poly);

%%%%%%%%%
% Check controllability
%%%%%%%%%
% Form controllability matrix W_c and check it's rank
W_c = [];
for i = 0:n-1
    W_c = horzcat(W_c, (A^i)*B);
end
% disp("Controllability Matrix: ")
% disp(W_c)
% fprintf("Rank of controllability matrix: %d \n", rank(W_c))
% Since controllability matrix is 4 (full rank). Hence all states are
% controllable.

%%%%%%%%%
% Obtain controllable canonical form
%%%%%%%%%
% Use reduced row echelon form algorithm to get n linearly indepenent
% columns from left to right
[R, pivots] = rref(W_c);
% disp("pivots selected for linearly independent vectors of W_c: ")
% disp(pivots)

% We select b1, b2, A*b1, A*b2, 
% Regroup the m as b1,  A*b1, b2, A*b2, 
C_ctrl = W_c(:, [1, 3, 2, 4]);
C_ctrl_inv = inv(C_ctrl);

% disp("C matrix (Control): ")
% disp(C_ctrl)
% disp("C inverse matrix (Control): ")
% disp(C_ctrl_inv)

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

% disp("A_bar: ")
% disp(A_bar)
% 
% disp("B_bar: ")
% disp(B_bar)

% There are 2 inputs and hence 2 non-trivial rows
% We can design the feedback gain matrix as follow

% We create K as a symbolic matrix
K_bar = sym('K_bar', [m,n]);

% Form closed loop system matrix for A_bar
A_bar_cl = A_bar - B_bar * K_bar;
% disp("A_bar_cl (Closed loop)")
% disp(A_bar_cl)

%%%%%%
% Get gain matrix K for closed loop system
%%%%%%
% From closed loop desired polynomial: (s + 18/25)*(s + 24/25)*((12*s)/25 + s^2 + 4/25) 
% Or expanded as s^4 + (54*s^3)/25 + (1036*s^2)/625 + (9384*s)/15625 + 1728/15625
% Construct the desired closed loop matrix
A_bar_cl_des = [0               1               0            0; ...
            0               0               1            0; ...
            0               0               0            1; ...
            -1728/15625     -9384/15625    -1036/625    -54/25;];

% Compare desired polynomial and closed loop polynomial to get values of
% gain matrix of K_bar
K_bar_eqn = A_bar_cl_des == A_bar_cl;
K_bar_soln = solve(K_bar_eqn, symvar(K_bar));
K_bar = subs(K_bar, K_bar_soln);

% Get gain matrix K
K = K_bar * T;

% disp("Gain matrix K: ");
% disp(vpa(K));

%%%%%%
% Form open loop system for simulation
%%%%%%

% Original open loop System
sys = ss(A, B, C, 0);

% % Get eigenvalues for open loop system matrix
% A_eigenvalues = eig(A);
% disp("Open loop system eigenvalues (A): ");
% disp(vpa(A_eigenvalues));

%%%%%%
% Form closed loop system for simulation
%%%%%%

% Get closed loop system matrix for A
A_cl = double(A - B * K);

% Closed loop System
sys_cl = ss(A_cl, B, C, 0);

% % Get eigenvalues for closed loop system matrix
A_cl_eigenvalues = eig(A_cl);
disp("Closed loop system eigenvalues (A_cl): ");
disp(vpa(A_cl_eigenvalues));

%%%%%%
% Get Step info response
%%%%%%
% Original open loop System
step_info_open = stepinfo(sys);

% Closed loop System
step_info_closed = stepinfo(sys_cl);

%%%%%%%%%
% Check step response data (OPEN LOOP)
%%%%%%%%%

disp("=========")
disp("Open loop step response")
disp("=========")

step_info_open_y1_u1 = step_info_open(1,1);
step_info_open_y2_u1 = step_info_open(2,1);
step_info_open_y1_u2 = step_info_open(1,2);
step_info_open_y2_u2 = step_info_open(2,2);

disp("With step input U_1 for output Y_1")
fprintf("Settling Time: %f \n", step_info_open_y1_u1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y1_u1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y1_u1));

disp("With step input U_1 for output Y_2")
fprintf("Settling Time: %f \n", step_info_open_y2_u1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y2_u1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y2_u1));

disp("With step input U_2 for output Y_1")
fprintf("Settling Time: %f \n", step_info_open_y1_u2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y1_u2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y1_u2));

disp("With step input U_2 for output Y_2")
fprintf("Settling Time: %f \n", step_info_open_y2_u2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y2_u2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y2_u2));

%%%%%%%%%
% Check step response data (CLOSED LOOP)
%%%%%%%%%
disp("=========")
disp("Closed loop step response")
disp("=========")

step_info_closed_y1_u1 = step_info_closed(1,1);
step_info_closed_y2_u1 = step_info_closed(2,1);
step_info_closed_y1_u2 = step_info_closed(1,2);
step_info_closed_y2_u2 = step_info_closed(2,2);

disp("With step input U_1 for output Y_1")
fprintf("Settling Time: %f \n", step_info_closed_y1_u1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_closed_y1_u1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y1_u1));

disp("With step input U_1 for output Y_2")
fprintf("Settling Time: %f \n", step_info_closed_y2_u1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_closed_y2_u1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y2_u1));

disp("With step input U_2 for output Y_1")
fprintf("Settling Time: %f \n", step_info_closed_y1_u2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_closed_y1_u2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y1_u2));

disp("With step input U_2 for output Y_2")
fprintf("Settling Time: %f \n", step_info_closed_y2_u2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_closed_y2_u2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y2_u2));

%%%%%%
% Functions
%%%%%%
function design_fulfilled = isDesignRequirementsMet(step_info)
    if step_info.SettlingTime < 20 && step_info.Overshoot < 10
        design_fulfilled = true;
    else
        design_fulfilled = false;
    end
end

% Get the dominant eigenvalue
function dom_eigenval = getDominantEigenval(M)
    [min_val, idx] = min(abs(real(M)));
    dom_eigenval = sign(real(M(idx))) * min_val;
end

% Remove small values below a certain threshold
function M = rmv_eps(M)
    M(abs(M)<1e-5)=0;
end
