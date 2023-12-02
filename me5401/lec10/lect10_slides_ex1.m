%%%%%%
% Decoupling control
%%%%%%
format long

%%%%%%
% Decoupling by state feedback
%%%%%%

%%%%%%
% State Space Model
%%%%%%

%Arbitrary params
% X_dot = A * X + B * U
% Y = C * X
[a, b, c, d] = deal(4, 9, 1, 2);

% State(or system) matrix
A = [0   1;
     -1 -2;];

% Input matrix
B = [1 0;
     0 1;];

% Output matrix
C = [1   0.5;
     1   1;];

D = [0, 0; 
     0, 0;];

x_0 = [0; 0;]

% Number of states n, outputs m 
n = size(A, 2);
m = size(C, 1);

fprintf("Num of states: %d \n", n);
fprintf("Num of outputs: %d \n", m);

%%%%%%
% Check G(s) if it is coupled
% G(s) = C * inv(S*I - A) * B
%%%%%%
s = sym('s');
G = C * inv(s*eye(n,n) - A) * B;
% G is not diagonal, indicating that it is coupled.

%%%%%%
% Calculate relative degree of transfer function G(s).
%%%%%%
% Let c_i.T represent each row of C
% Let g_i.T represent each row of G(s) 
% g_i.T = c_i.T * B * (s^-1) + c_i.T * A * B * (s^-2) + ... + c_i.T * (A^(n-1)) * B * (s^-n)

C(1, :) * A^(j-1) * B

% To get sigma_1, relative degree of first row 
% Check j = 1
i = 1
j = 1
C(i, :) * A^(j-1) * B

% To get sigma_2, relative degree of second row
i = 2
j = 1
C(i, :) * A^(j-1) * B

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

B_star

%%%%%%
% Get C* with desired poles
%%%%%%

C_star = [C(1, :) * (A^sigma(1) + -des_poles(1) * eye(n,n));
          C(2, :) * (A^sigma(2) + -des_poles(2) * eye(n,n)); ]

%%%%%%
% Get F and K such that we can decouple the system through full state
% feedback using the control law u = - K*x + F*r 
%%%%%%
F = inv(B_star)
K = inv(B_star) * C_star

%%%%%%
% Form closed loop system and get decoupled transfer function H(s)
%%%%%%
A_cl = A - B*K

% Get closed loop transfer function H(s) and verify that it is decoupled
H_s = simplify(C * inv(s*eye(n,n) - (A-B*K)) * B * F)

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








