
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




% Although system is 3rd order, we can approximate the system as a second
% order system. This is because the system's response is dominated by the
% slow mode.
% 
% %%%%%%%%%
% % Get equation of Desired poles
% %%%%%%%%%
% % From design requirements, we get the range of damping ratio and
% % natural frequency.
% syms xi om;
% 
% eqn_settling_time = 4/(xi*om) == 0.04;
% eqn_overshoot = exp((-pi*xi)/sqrt(1-xi^2)) == 0.16;
% eqns = [eqn_settling_time, eqn_overshoot];
% S = solve(eqns, [xi, om]);
% fprintf('S.xi > %f.\n', S.xi);
% fprintf('S.om >= %f.\n', S.om);
% 
% % Based on xi > 0.47 and xi*om > 100, we choose the following values:
% xi = 0.657;
% om = 300;
% 
% % Get Dominant/Slow poles
% des_pole_0 = - xi * om + 1i*(om*sqrt(1-xi^2));
% des_pole_1 = conj(des_pole_0);
% % Get Fast poles, they have to be far away from dominant one (2-5 times faster)
% des_pole_2 = -200;
% 
% des_poles = [des_pole_0 des_pole_1 des_pole_2];
% disp("Desired poles: ")
% disp(des_poles)
% 
% % Closed loop characteristic polynomial
% syms s;
% closed_loop_char_poly = vpa(expand((s-des_poles(1)) * (s-des_poles(2)) * (s-des_poles(3))))
% 
% %%%%%%%%%
% % Get gain matrix K using ackermann's formula
% %%%%%%%%%
% % Construct characteristic equation of A from closed loop characteristic
% % polynomial
% A_polynomial = A^3 + 400*A^2 + (515447974398397*A)/8589934592 + 4296264767959925/1073741824;
% 
% % Using ackerman's formula to get gain matrix K
% ctrb_mat = [B A*B (A^2)*B];
% ctrb_mat_inv = inv(ctrb_mat);
% 
% disp("Gain matrix K From ackerman's formula")
% % K = transpose([0, 0, 1;] * ctrb_mat_inv * A_polynomial)
% K = transpose(place(A, B, des_poles))
% 
% %%%%%%%%%
% % Set up closed loop systemm
% %%%%%%%%%
% 
% % Check closed loop eigenvalues
% A_closed = A - B * K';
% A_closed_eigenvalues = eig(A_closed);
% disp("Closed loop eigenvalues (A): ")
% disp(A_closed_eigenvalues)
% 
% % Create closed loop system
% sys_closed = ss(A_closed, B, C, 0);
% 
% %%%%%%%%%
% % Display step response of closed loop system
% %%%%%%%%%
% % step(sys)
% step(sys_closed)
% step_info_closed = stepinfo(sys_closed);
% step_info_closed
% 
% fprintf('Closed Loop to Desired Settling time: %d < %d ?\n', step_info_closed.SettlingTime, 0.04);
% fprintf('Closed Loop to Desired Peak Overshoot: %d < %d ?\n', step_info_closed.Overshoot, 0.16);
% 
% fprintf('Is design requirement met? %d \n', isDesignRequirementsMet(sys_closed));
% 
% function design_fulfilled = isDesignRequirementsMet(sys)
%     step_info = stepinfo(sys);
%     if step_info.SettlingTime < 0.04 ...
%        && step_info.Overshoot < 0.16
%         design_fulfilled = true;
%     else
%         design_fulfilled = false;
%     end
% end
% 
% % Get the dominant eigenvalue
% function dom_eigenval = getDominantEigenval(M)
%     [min_val, idx] = min(abs(real(M)));
%     dom_eigenval = sign(real(M(idx))) * min_val;
% end
% 
