%%%%%%
% Decoupling control
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
A = [0   1;
     -1 -2];

% Input matrix
B = [1 0;
     0 1;];

% Output matrix
C = [1 0.5;
     1   1;];

D = [0, 0; 
     0, 0;];


% Number of states n, outputs m 
n = size(A, 2);
m = size(C, 1);

fprintf("Num of states: %d \n", n);
fprintf("Num of outputs: %d \n", m);

%%%%%%
% Check G(s) if it is coupled
% G(s) = C * inv(S*I - A) * B
%%%%%%



%%%%%%
% Calculate relative degree
%%%%%%


%%%%%%
% Get B* and check if it is non-singular
% If so, system can be decoupled
%%%%%%


%%%%%%
% Get C** with desired poles
%%%%%%

%%%%%%
% Construct controller 
%%%%%%
F = inv(B_star)
K = inv(B_star) * C_star_star

%%%%%%
% Get decoupled transfer function H(s)
%%%%%%


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








