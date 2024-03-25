%%%%%%
% State Space Model
%%%%%%

% State(or system) matrix
A = [-3];


% Input matrix
B = [1];

% Number of states n
n = size(A, 2);
m = size(B, 2);

% State variables
X = sym('X', [n,1]);

%%%%%%
% Cost function (LQR)
%%%%%%
Q = [1]; % weighting of x
R = [1]; % weighting of u

%%%%%%
% Obtain P within the algebraic riccati equation
% ARE: A.'*P + P*A + Q - P*B*inv(R)*B.'*P = 0
%%%%%%

% Form 2n x 2n matrix gamma
gamma = [A,  -B*inv(R)*B.';
         -Q, -A.';]

% Obtain stable eigenvalues of gamma 
[gamme_eigvec, gamma_eigval] = eig(gamma);

% Obtain eigenvector corresponding to stable eigenvalue. 
% In this case, we use the right eigenvectors
[stable_eigval, idx_stable_eigval] = min(diag(gamma_eigval));
if (stable_eigval > 0)
    fprintf("ERROR! Eigenvalue should be stable");
end 

stable_eigvec = gamme_eigvec(:, idx_stable_eigval);
nu = stable_eigvec(1:n);
miu= stable_eigvec(n+1:2*n);

P = miu * inv(nu)

%%%%%%
% Get optimal control u
%%%%%%
u = vpa(-inv(R) * B.' * P * X)

