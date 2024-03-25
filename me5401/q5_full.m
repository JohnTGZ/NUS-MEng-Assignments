%%%%%%
% Question 5: Design a controller such that the
% plant (the diesel engine system) can operate around the set point as close as possible at steady
% state even when step disturbances are present at the plant input. Plot out both the control and
% output signals.
%%%%%%

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

% Number of states n, outputs m 
n = size(A, 2);
m = size(C, 1);

fprintf("Num of states: %d \n", n);
fprintf("Num of outputs: %d \n", m);

%%%%%%
% Check controllability by checking that the rank of [A, B; C, 0;] == n + m
%%%%%%
% For a mxm plant where there are m inputs and m outputs
% Check that augmented system is controllable by checking that [A, B; C, 0;] == n + m 
if (rank([A, B; C, zeros(m,m);]) == (n + m))
    fprintf("[A, B; C, 0;] matrix is full rank at %d\n", rank([A, B; C, zeros(m,m);]))
else
    fprintf("[A, B; C, 0;] matrix is not full rank at %d\n", rank([A, B; C, zeros(m,m);]))
end 


%%%%%%
% If augmented system is controllable, it can be stab
% Form augmented system
%%%%%%
A_bar = [A,  zeros(n, m);
         -C, zeros(m, m);];

B_bar = [B;
         zeros(m, m);];

% B_w_bar = [eye(m,m);
%            zeros(m,m);]

% B_r_bar = [zeros(n,m);
%            eye(m,m);];

C_bar = [C, zeros(m,m);];

%%%%%%
% We use LQR to stabilize the augmented system
%%%%%%

% We want to minimize J = integral(x_bar.T * Q * x_bar + u.T * R * u) with respect to dt
% First we solve the algebraic riccati equation to obtain the gain matrix

% Q is weight matrix of size n-m x n+m
% R is weight matrix of size m x m

Q = [1 0 0 0 0 0;
     0 1 0 0 0 0;
     0 0 1 0 0 0;
     0 0 0 1 0 0;
     0 0 0 0 1000 0;
     0 0 0 0 0 100;];

R = [0.0001 0;
     0 0.0001;];

[X,K,L] = icare(A_bar,B_bar,Q,R,[],[],[]);

% % Obtain gain matrices K1 and K2 from the LQR gain matrix
% K1 = K(:, 1:n);
% K2 = K(:, n+1:end);

%%%%%%%%%
% Store matrices for state observer
%%%%%%%%%
D = [-1 0; 
     0 -1;];
E = [-0.179108013653627  -0.106649750104643
      0.455492072025065   0.059394579209481];
G = [1 0; 
     0 1;];
C_T_matrix_inv = [-0.292392890492903   0.278799577693527  -0.115994901359206   0.063648155853290;
                  -0.027045766046657  -0.439986590393009   0.034561335477943  -0.028620242458612;
                  -0.565753323097382  -0.212213296092144  -8.104940536716425   3.312412963238812;
                   0.020641439655510  -0.603303471575275   0.955724158055884  -2.522510584828376;];

%%%%%%%%%
% Check setpoint response data 
%%%%%%%%%

% Form closed loop system and measure step response
out.setpoint_response.Data;
setpoint_stepinfo = stepinfo(out.setpoint_response.Data,out.setpoint_response.Time);

disp("=========")
disp("Open loop step response")
disp("=========")

step_info_open_y1 = setpoint_stepinfo(1,1);
step_info_open_y2 = setpoint_stepinfo(2,1);

disp("Setpoint stepinfo output Y_1")
fprintf("Settling Time: %f \n", step_info_open_y1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y1));

disp("Setpoint stepinfo for output Y_2")
fprintf("Settling Time: %f \n", step_info_open_y2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y2));
    
%%%%%%%%%
% FUnction definitions
%%%%%%%%%

function design_fulfilled = isDesignRequirementsMet(step_info)
    if step_info.SettlingTime < 20 && step_info.Overshoot < 10
        design_fulfilled = true;
    else
        design_fulfilled = false;
    end
end

% Remove small values below a certain threshold
function M = rmv_eps(M)
    M(abs(M)<1e-5)=0;
end




