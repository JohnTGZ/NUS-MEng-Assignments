format long
%%%%%%
% Question
%%%%%%
% Design a decoupling controller with closed-loop stability and simulate the step response of the
% resultant control system to verify decoupling performance with stability. In this question, the
% disturbance can be assumed to be zero. Is the decoupled system internally stable? Please provide
% both the step (transient) response with zero initial states and the initial response with respect to
% x_0 of the decoupled system to support your conclusion

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

% Number of states n and outputs m
n = size(A, 2);
m = size(C, 1);

fprintf("Num of states: %d \n", n);
fprintf("Num of outputs: %d \n", m);
%%%%%%
% Check G(s) if it is coupled
% G(s) = C * inv(S*I - A) * B
%%%%%%
s = sym('s');

% G = simplify(C * ((s*eye(n,n) - A) \ B))
G = simplify(vpa(C) * vpa(inv( s*eye(n,n) - A )) * vpa(B))
% G is not a diagonal matrix, indicating that it is coupled.

%%%%%%
% Calculate relative degree of transfer function G(s).
%%%%%%% 
% Let c_i.T represent each row of C
% Let g_i.T represent each row of G(s) 
% g_i.T = c_i.T * B * (s^-1) + c_i.T * A * B * (s^-2) + ... + c_i.T * (A^(n-1)) * B * (s^-n)

% To get sigma_1, relative degree of first row 
% C(1, :) * B % NON ZERO
% C(1, :) * A * B
% C(1, :) * (A^2) * B
% C(1, :) * (A^3) * B

% To get sigma_2, relative degree of second row
% C(2, :) * B % NON ZERO
% C(2, :) * A * B
% C(2, :) * (A^2) * B
% C(2, :) * (A^3) * B

% sigma contains the relative degrees of each row
sigma = [1, 1];

%%%%%%
% Get B* and check if it is non-singular
% If so, system can be decoupled
%%%%%%

B_star = [];
for i = 1:m
    B_star = vertcat(B_star, C(i, :) * A^(sigma(i)-1) * B);
end 

% Check non singularity of B_star by checking if it's determinant is
% non-zero
% det(B_star) is not zero

det(B_star)

%%%%%%
% Get C* with desired poles
%%%%%%

% Our desired poles are: 
% -0.240000000000000 + 0.320000000000000i 
% -0.240000000000000 - 0.320000000000000i 
% -0.720000000000000 + 0.000000000000000i 
% -0.960000000000000 + 0.000000000000000i
des_poles = [0.24 , 0.24 ];

C_star = [C(1, :) * (A + des_poles(1) * eye(n,n));
          C(2, :) * (A + des_poles(2) * eye(n,n)); ]

%%%%%%
% Get F and K such that we can decouple the system through full state
% feedback using the control law u = - K*x + F*r 
%%%%%%
F = inv(B_star)
K = inv(B_star) * C_star


%%%%%%
% Form closed loop system and get decoupled transfer function H(s)
%%%%%%
A_cl = A - B*K;

latex(vpa(A_cl, 3))

% Get closed loop transfer function H(s) and verify that it is decoupled
H_s = simplify(C * inv(s*eye(n,n) - (A-B*K)) * B * F)

latex(vpa(expand(H_s), 3))

% Get eigenvalues for open loop system matrix
A_eigenvalues = eig(A);
disp("Open loop system eigenvalues (A): ");
disp(vpa(A_eigenvalues));

% Get eigenvalues for closed loop system matrix
A_cl_eigenvalues = eig(A_cl);
disp("Closed loop system eigenvalues (A_cl): ");
disp(vpa(A_cl_eigenvalues));

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




