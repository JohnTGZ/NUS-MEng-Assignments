format long
%%%%%%
% Question
%%%%%%
% Assume you can only measure the two outputs. Design a state observer, simulate the resultant
% observer-based LQR control system, monitor the state estimation error, investigate effects of
% observer poles on state estimation error and closed-loop control performance. In this step, both
% the disturbance and set point can be assumed to be zero.

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
     -8.5645-(a-b)/(c+d+2), 8.3742,               -4.4331,               -7.7181*(c+5)/(b+5);]

% Input matrix
B = [0.0564+(b)/(10+c),           0.0319; 
     0.0165-(c+d-5)/(1000+20*a),  -0.02; 
     4.4939,                      1.5985*(a+10)/(b+12); 
     -1.4269,                     -0.2730;]

% Output matrix
C = [-3.2988,           -2.1932+(10*c+d)/(100+5*a), 0.0370,  -0.0109; 
     0.2922-(a*b)/500,  -2.1506,                   -0.0104,   0.0163;]

D = [0, 0; 
     0, 0;]

x_0 = [0.5; -0.1; 0.3; -0.8;];

u_1 = [1; 0;];
u_2 = [0; 1;];


% Number of states n
n = size(A, 2);
m = size(C, 1);

%%%%%%%%%
% We design a reduced-order state observer
%%%%%%%%%

%%%%%%%%%
% Check observability
%%%%%%%%%
observability_matrix = [C.', A.'*C.', (A.')^2 * C.', (A.')^3 * C.'];


% disp("Observability Matrix: ")
% disp(observability_matrix)
fprintf("Rank of observability matrix: %d \n", rank(observability_matrix))
% Since the rank of the observability matrix is 4 (full rank). 
% Hence all states are observable.

% Number of states to estimate
num_est_states = n - m;
fprintf("We want to estimate %d state variables\n", num_est_states)

% We create a second order observer 
% xi_dot = D * xi + E * u + G * y

%%%%%%%%%
% Find constraints on T such taht [C; T;] is non-singular
%%%%%%%%%
T = sym('t', [num_est_states,n]);


% C_T_matrix: State variable transformation matrix
C_T_matrix = [C; T;];
% Get determinant of C_T_Matrix
disp("Determinant of C_T_matrix:")
disp(det(C_T_matrix))

% For C_T to be non-singular
% det(C_T_matrix) must not equal 0

%%%%%%%%%
% Choose D such that it's eigenvalues have negative real parts, or
% desired decay rates
%%%%%%%%%
% D is a 2x2 matrix
D = [-1 0;
     0 -1;];

%%%%%%%%%
% Solve T*A -D*T = G*C for T and G
%%%%%%%%%
G = sym('g', [num_est_states, m]);

% There are an infinite number of solutions, so we choose values of g.
% To get G, choose g1 = 10 and g2 = 1 
G = double(subs(G, [struct('g1_1', 1, 'g1_2', 0, 'g2_1', 0, 'g2_2', 1)]))

lhs_eqn = T * A - D * T
rhs_eqn = G * C

% Solve linear system of equations T*A -D*T = G*C
% assume(C_T_matrix_det > 0);
eqn = T * A - D * T == G * C;
T_soln = solve(eqn, symvar(T))

% Get T
T = double(subs(T, T_soln));

disp("T:")
disp(vpa(T))


% Check if C_T_matrix is singular
C_T_matrix = [C; T;];
% disp("C_T_matrix:")
% disp(vpa(C_T_matrix))

disp("Determinant of C_T_matrix:")
disp(vpa(det(C_T_matrix)))
% Determinant of C_T_matrix is not zero, hence C_T_Matrix is non-singular

%%%%%%%%%
% Calculate E = TB
%%%%%%%%%

E = T * B;

%%%%%%%%%
% Observer equation
%%%%%%%%%
y = sym('y', [m, 1]);
u = sym("u");

% Observer is then:
% xi_dot = D*xi + E*u + G*y

%%%%%%%%%
% Reconstruct state variables from plant and observer's output
%%%%%%%%%
xi = sym("xi", [num_est_states, 1]);

C_T_matrix_inv = inv(C_T_matrix);

x_est = C_T_matrix_inv * [y; xi;];

C_T_matrix_inv

%%%%%%%%%
% Use LQR gain matrix from Q2
%%%%%%%%%

K = 1.0e+02 * [-0.043600269508890   0.238567661568677  -0.002330534139679  -0.405118256624524;
  -0.196741470090894  -2.005606595495490   0.281426302914144   0.025449196238241;];

% For input U1: Form closed loop system and measure step response
setpoint_stepinfo_u1 = stepinfo(out.setpoint_response_u1.Data,out.setpoint_response_u1.Time);
setpoint_stepinfo_u2 = stepinfo(out.setpoint_response_u2.Data,out.setpoint_response_u2.Time);

%%%%%%%%%
% Check setpoint response data for input U1
%%%%%%%%%

disp("=========")
disp("Open loop step response for input U1")
disp("=========")

step_info_open_y1 = setpoint_stepinfo_u1(1,1);
step_info_open_y2 = setpoint_stepinfo_u2(2,1);

disp("Setpoint stepinfo output Y_1")
fprintf("Settling Time: %f \n", step_info_open_y1.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y1.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y1));

disp("Setpoint stepinfo for output Y_2")
fprintf("Settling Time: %f \n", step_info_open_y2.SettlingTime)
fprintf("Peak overshoot: %f %% \n", step_info_open_y2.Overshoot)
fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_open_y2));
    

%%%%%%%%%
% Check setpoint response data for input U2
%%%%%%%%%

disp("=========")
disp("Open loop step responsefor input U2")
disp("=========")

step_info_open_y1 = setpoint_stepinfo_u2(1,1);
step_info_open_y2 = setpoint_stepinfo_u2(2,1);

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




