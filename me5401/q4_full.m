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

u_1 = [1; 0;];
u_2 = [0; 1;];

% Number of states n and outputs m
n = size(A, 2);
m = size(C, 1);

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




