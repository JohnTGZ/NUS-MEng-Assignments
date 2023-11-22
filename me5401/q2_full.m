format long
%%%%%%
% Question
%%%%%%
% Assume that you can measure all the four state variables, design a state feedback controller using
% the LQR method, simulate the designed system, check the step responses and show all the state
% responses to non-zero initial state with zero external inputs. Discuss effects of weightings Q and
% R on system performance, and also monitor control signal size. In this step, both the disturbance
% and set point can be assumed to be zero.

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

% Number of states n and inputs m
n = size(A, 2);
m = size(B, 2);

%%%%%%
% Cost function (LQR)
% J = (1/2) * integrate_from_0_to_inf(x.'*Q*x + u.'*R*u)dt
%%%%%%

% Taking a look at C matrix
disp("C")
disp(vpa(C))
% We observe that for output y1, state variables x1 and x2 have a
% relatively greater influence than the other state variables
% We observe that for output y2, state variables x2 has a relatively 
% greater influence than the other state variables
% The weighting we choose for Q will reflect this. Adjustment is done by
% factors of 10.

% Q is weighting of x with size (nxn)
% Q is semi-positive definite and diagonal
% Choosing a the diagonal values of Q to be larger relative to R, the
% system will converge to equilibrium faster (higher response speed) but at 
% the cost of higher control effort.
Q = [100 0 0 0;
     0 1000 0 0;
     0 0 10 0;
     0 0 0 1;]; 

% R is weighting of u with size (mxm)
% R is positive definite and diagonal
% We observe the response of output w.r.t the step inputs and adjust the
% weights accordingly
R = [0.1 0;
     0 0.01;]; 

%%%%%%
% Obtain P within the algebraic riccati equation
% ARE: A.'*P + P*A + Q - P*B*inv(R)*B.'*P = 0
%%%%%%

% Form 2n x 2n matrix gamma
gamma = [A,  -B*inv(R)*B.';
         -Q, -A.';];

% Obtain stable eigenvalues of gamma 
[gamma_eigvec, gamma_diag_eigval] = eig(gamma);

% % Obtain eigenvector corresponding to stable eigenvalue. 
% % In this case, we use the right eigenvectors
% [stable_eigval, idx_stable_eigval] = min(diag(gamma_eigval));
% if (stable_eigval > 0)
%     fprintf("ERROR! Eigenvalue should be stable");
% end 

gamma_eigval = diag(gamma_diag_eigval);

idx_stable_eigval = [];

for i = 1: size(gamma_eigval, 1)
    if real(real(gamma_eigval(i))) <= 0
        idx_stable_eigval = [idx_stable_eigval i];
    end 
end 

stable_eigvec = gamma_eigvec(:, idx_stable_eigval);

nu = stable_eigvec(1:n, :);
miu= stable_eigvec(n+1:2*n, :);

P = miu * inv(nu);

%%%%%%
% Get gain matrix K for closed loop system
%%%%%%
K = real(inv(R) * B.' * P);

%%%%%%
% Form open loop system for simulation
%%%%%%
% Original open loop System
sys = ss(A, B, C, 0);

% Get eigenvalues for open loop system matrix
A_eigenvalues = eig(A);
disp("Open loop system eigenvalues (A): ");
disp(vpa(A_eigenvalues));

%%%%%%
% Form closed loop system for simulation
%%%%%%

% Get closed loop system matrix for A
A_cl = double(A - B * K);

% Closed loop System
% x_dot = (A - B * K)x 
sys_cl = ss(A_cl, B, C, 0);

% Get eigenvalues for closed loop system matrix
A_cl_eigenvalues = eig(A_cl);
disp("Closed loop system eigenvalues (A_cl): ");
disp(vpa(A_cl_eigenvalues));

%%%%%%%%%
% Obtain 4 state responses to non-zero initial state with zero external
% inputs
%%%%%%%%%
figure(1)

[y_init, tOut, x_init] = initial(sys, x_0);
[y_cl_init, tOut_cl, x_cl_init] = initial(sys_cl, x_0);

tlay_1 = tiledlayout(2,1);
title(tlay_1, '4 state variable responses with zero external input and non-zero initial state');
xlabel(tlay_1, 'Time');
ylabel(tlay_1, 'Amplitude');

ax1 = nexttile(tlay_1);
plot(ax1, tOut, x_init);
title(ax1, '[Open loop]')

ax2 = nexttile(tlay_1);
plot(ax2, tOut_cl, x_cl_init);
title(ax2, '[Closed loop]')

%%%%%%%%%
% Obtain step response of open loop system
%%%%%%%%%
figure(2)

[y_step, tOut, x_step] = step(sys);

tlay_2 = tiledlayout(2,2);

title(tlay_2, 'Open loop step response');
xlabel(tlay_2, 'Time');
ylabel(tlay_2, 'Amplitude');

ax1 = nexttile(tlay_2);
plot(ax1, tOut, y_step(:, 1,1));
title(ax1, 'y1 output for u = [1,0].T ')

ax2 = nexttile(tlay_2);
plot(ax2, tOut, y_step(:, 2,1));
title(ax2, 'y2 output for u = [1,0].T ')

ax3 = nexttile(tlay_2);
plot(ax3, tOut, y_step(:, 1,2));
title(ax3, 'y1 output for u = [1,0].T ')

ax4 = nexttile(tlay_2);
plot(ax4, tOut, y_step(:, 2,2));
title(ax4, 'y2 output for u = [1,0].T ')

%%%%%%%%%
% Obtain step response of closed loop system
%%%%%%%%%
figure(3)
[y_step, tOut, x_step] = step(sys_cl);

tlay_3 = tiledlayout(2,2);

title(tlay_3, 'Closed loop step response');
xlabel(tlay_3, 'Time');
ylabel(tlay_3, 'Amplitude');

ax1 = nexttile(tlay_3);
plot(ax1, tOut, y_step(:, 1,1));
title(ax1, 'y1 output for u = [1,0].T ')

ax2 = nexttile(tlay_3);
plot(ax2, tOut, y_step(:, 2,1));
title(ax2, 'y2 output for u = [1,0].T ')

ax3 = nexttile(tlay_3);
plot(ax3, tOut, y_step(:, 1,2));
title(ax3, 'y1 output for u = [1,0].T ')

ax4 = nexttile(tlay_3);
plot(ax4, tOut, y_step(:, 2,2));
title(ax4, 'y2 output for u = [1,0].T ')


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




