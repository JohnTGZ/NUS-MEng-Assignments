%%%%%%
% State Space Model
%%%%%%

% State(or system) matrix
A = [-0.313  56.7   0; 
     -0.0139 -0.426 0;
     0       56.7   0;];

% Input matrix
B = [0.232; 
     0.0203;
     0;];

C = [0 0 1];

% Number of states n
n = size(A, 2);
m = size(B, 2);

% State variables
X = sym('X', [n,1]);

%%%%%%
% Cost function (LQR)
%%%%%%
Q = [0 0 0;
     0 0 0;
     0 0 50;]; % weighting of x

R = [1]; % weighting of u

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
    disp(i)
    disp(real(gamma_eigval(i)))
    if real(real(gamma_eigval(i))) <= 0
        disp("stable!")
        idx_stable_eigval = [idx_stable_eigval i];
    end 
end 

stable_eigvec = gamma_eigvec(:, idx_stable_eigval);

stable_eigvec
nu = stable_eigvec(1:n, :);
miu= stable_eigvec(n+1:2*n, :);

P = miu * inv(nu)

%%%%%%
% Get gain matrix K
%%%%%%
K = real(inv(R) * B.' * P);

%%%%%%
% Form closed loop system
%%%%%%

% Original open loop System
sys = ss(A, B, C, 0);
% Closed loop System
% x_dot = (A - B * K)x
A_cl = (A - B * K)
sys_cl = ss(A_cl, B, C, 0);


%%%%%%%%%
% Obtain step response
%%%%%%%%%

% % Display step response of open loop system
% [y_step, tOut, x_step] = step(sys);
% 
% tiledlayout(2,2)
% 
% ax1 = nexttile;
% plot(ax1, tOut, y_step(:, 1,1));
% title(ax1, '[Open loop] y output for u = [1,0].T ')
% xlabel(ax1, 'Time');
% ylabel(ax1, 'Amplitude');
% 
% ax2 = nexttile;
% plot(ax2, tOut, y_step(:, 2,1));
% title(ax2, '[Open loop] y output for u = [1,0].T ')
% xlabel(ax2, 'Time');
% ylabel(ax2, 'Amplitude');
% 
% ax3 = nexttile;
% plot(ax3, tOut, y_step(:, 1,2));
% title(ax3, '[Open loop] y output for u = [1,0].T ')
% xlabel(ax3, 'Time');
% ylabel(ax3, 'Amplitude');
% 
% ax4 = nexttile;
% plot(ax4, tOut, y_step(:, 2,2));
% title(ax4, '[Open loop] y output for u = [1,0].T ')
% xlabel(ax4, 'Time');
% ylabel(ax4, 'Amplitude');

% Display step response of closed loop system
[y_step, tOut, x_step] = step(sys_cl);

tiledlayout(2,2)

ax1 = nexttile;
plot(ax1, tOut, y_step(:, 1,1));
title(ax1, '[Closed loop] y output for u = [1,0].T ')
xlabel(ax1, 'Time');
ylabel(ax1, 'Amplitude');

% ax2 = nexttile;
% plot(ax2, tOut, y_step(:, 2,1));
% title(ax2, '[Closed loop] y output for u = [1,0].T ')
% xlabel(ax2, 'Time');
% ylabel(ax2, 'Amplitude');

% ax3 = nexttile;
% plot(ax3, tOut, y_step(:, 1,2));
% title(ax3, '[Closed loop] y output for u = [1,0].T ')
% xlabel(ax3, 'Time');
% ylabel(ax3, 'Amplitude');
% 
% ax4 = nexttile;
% plot(ax4, tOut, y_step(:, 2,2));
% title(ax4, '[Closed loop] y output for u = [1,0].T ')
% xlabel(ax4, 'Time');
% ylabel(ax4, 'Amplitude');

%%%%%%%%%
% Check step response data
%%%%%%%%%

step_info_closed = stepinfo(sys_cl);

step_info_closed

% step_info_closed_y1_u1 = step_info_closed(1,1);
% step_info_closed_y2_u1 = step_info_closed(2,1);
% step_info_closed_y1_u2 = step_info_closed(1,2);
% step_info_closed_y2_u2 = step_info_closed(2,2);
% 
% disp("Required Settling time = 10%")
% disp("Required peak overshoot = 20s")
% 
% disp("With step input U_1 for output Y_1")
% fprintf("Settling Time: %f \n", step_info_closed_y1_u1.SettlingTime)
% fprintf("Peak overshoot: %f %% \n", step_info_closed_y1_u1.Overshoot)
% fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y1_u1));
% 
% disp("With step input U_1 for output Y_2")
% fprintf("Settling Time: %f \n", step_info_closed_y2_u1.SettlingTime)
% fprintf("Peak overshoot: %f %% \n", step_info_closed_y2_u1.Overshoot)
% fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y2_u1));

% disp("With step input U_2 for output Y_1")
% fprintf("Settling Time: %f \n", step_info_closed_y1_u2.SettlingTime)
% fprintf("Peak overshoot: %f %% \n", step_info_closed_y1_u2.Overshoot)
% fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y1_u2));
% 
% disp("With step input U_2 for output Y_2")
% fprintf("Settling Time: %f \n", step_info_closed_y2_u2.SettlingTime)
% fprintf("Peak overshoot: %f %% \n", step_info_closed_y2_u2.Overshoot)
% fprintf('Is design requirement met? %d \n \n', isDesignRequirementsMet(step_info_closed_y2_u2));


function design_fulfilled = isDesignRequirementsMet(step_info)
    if step_info.SettlingTime < 20 && step_info.Overshoot < 10
        design_fulfilled = true;
    else
        design_fulfilled = false;
    end
end

