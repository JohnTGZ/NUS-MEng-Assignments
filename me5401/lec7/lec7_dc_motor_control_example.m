
% State Space Model
format shortEng

%Arbitrary params
[J, b, K, R, L] = deal(3.2284*(10^-6), 3.5077*(10^-6), 0.0274, 4, 2.75*(10^-6));

% State(or system) matrix
A = [0, 1,      0; ...
     0, -b/J,   K/J; ...
     0, -K/L, -R/L;];

B = [0; ...
     0; ...
     1/L;];

C = [1, 0, 0];

% Original open loop System
sys = ss(A, B, C, 0);

% Check eigenvalues of open loop system matrix
A_eigenvalues = eig(A);
disp("Open loop eigenvalues (A): ")
disp(A_eigenvalues)

%%%%%%%%%
% Check controllability
%%%%%%%%%
ctrb_mat = ctrb(A,B);
disp("Rank of controllability matrix: ")
disp(rank(ctrb_mat))

% Although system is 3rd order, we can approximate the system as a second
% order system. This is because the system's response is dominated by the
% slow mode.

%%%%%%%%%
% Get equation of Desired poles
%%%%%%%%%
% From design requirements, we get the range of damping ratio and
% natural frequency.
syms xi om;

eqn_settling_time = 4/(xi*om) == 0.04;
eqn_overshoot = exp((-pi*xi)/sqrt(1-xi^2)) == 0.16;
eqns = [eqn_settling_time, eqn_overshoot];
S = solve(eqns, [xi, om]);
fprintf('S.xi > %f.\n', S.xi);
fprintf('S.om >= %f.\n', S.om);

% Based on xi > 0.47 and xi*om > 100, we choose the following values:
xi = 0.657;
om = 300;

% Get Dominant/Slow poles
des_pole_0 = - xi * om + 1i*(om*sqrt(1-xi^2));
des_pole_1 = conj(des_pole_0);
% Get Fast poles, they have to be far away from dominant one (2-5 times faster)
des_pole_2 = -200;

des_poles = [des_pole_0 des_pole_1 des_pole_2];
disp("Desired poles: ")
disp(des_poles)

% Closed loop characteristic polynomial
syms s;
closed_loop_char_poly = vpa(expand((s-des_poles(1)) * (s-des_poles(2)) * (s-des_poles(3))))

%%%%%%%%%
% Get gain matrix K using ackermann's formula
%%%%%%%%%
% Construct characteristic equation of A from closed loop characteristic
% polynomial
A_polynomial = A^3 + 400*A^2 + (515447974398397*A)/8589934592 + 4296264767959925/1073741824;

% Using ackerman's formula to get gain matrix K
ctrb_mat = [B A*B (A^2)*B];
ctrb_mat_inv = inv(ctrb_mat);

disp("Gain matrix K From ackerman's formula")
% K = transpose([0, 0, 1;] * ctrb_mat_inv * A_polynomial)
K = transpose(place(A, B, des_poles))

%%%%%%%%%
% Set up closed loop systemm
%%%%%%%%%

% Check closed loop eigenvalues
A_closed = A - B * K';
A_closed_eigenvalues = eig(A_closed);
disp("Closed loop eigenvalues (A): ")
disp(A_closed_eigenvalues)

% Create closed loop system
sys_closed = ss(A_closed, B, C, 0);

%%%%%%%%%
% Display step response of closed loop system
%%%%%%%%%
% step(sys)
step(sys_closed)
step_info_closed = stepinfo(sys_closed);
step_info_closed

fprintf('Closed Loop to Desired Settling time: %d < %d ?\n', step_info_closed.SettlingTime, 0.04);
fprintf('Closed Loop to Desired Peak Overshoot: %d < %d ?\n', step_info_closed.Overshoot, 0.16);

fprintf('Is design requirement met? %d \n', isDesignRequirementsMet(sys_closed));

function design_fulfilled = isDesignRequirementsMet(sys)
    step_info = stepinfo(sys);
    if step_info.SettlingTime < 0.04 ...
       && step_info.Overshoot < 0.16
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
