format long
%%%%%%
% State Space Model
%%%%%%

% State(or system) matrix
A = [0 1 0;
     0 0 1;
     1 0 0;];

% Input matrix
B = [0;
     1;
     0;];

% Output matrix
C = [1 0 0;
     1 1 0;];

D = [0; 
     0;];

% Number of states n
n = size(A, 2);
m = size(C, 1);

%%%%%%%%%
% Check observability
%%%%%%%%%
observability_matrix = [C.' A.'*C.' (A.')^2 * C.'];
% disp("Observability Matrix: ")
% disp(observability_matrix)
fprintf("Rank of observability matrix: %d \n", rank(observability_matrix))
% Since observability matrix is 3 (full rank). Hence all states are
% observable.

% Number of states to estimate
num_est_states = n - m;
fprintf("We want to estimate %d state variables\n", num_est_states)

% We create a first order observer 
% xi_dot = d * xi + e * xi + G * y


%%%%%%%%%
% Find constraints on T such taht [C; T;] is non-singular
%%%%%%%%%

T = sym('t', [num_est_states,n]);

% C_T_matrix: State variable transformation matrix
C_T_matrix = [C; T;];
% Get determinant of C_T_Matrix
det_trans = det(C_T_matrix);
disp("Determinant of C_T_matrix:")
disp(det_trans)

%%%%%%%%%
% Choose D such that it's eigenvalues have negative real parts, or
% desired decay rates
%%%%%%%%%
D = -2;

%%%%%%%%%
% Solve T*A -D*T = G*C for T and G
%%%%%%%%%
G = sym('g', [num_est_states, m]);

% There are an infinite number of solutions, so we choose values of g.
% To get G, choose g1 = 10 and g2 = 1 
G = subs(G, [struct('g1', 10, 'g2', 1)])

% Solve linear system of equations T*A -D*T = G*C
eqn = T * A - D * T == G * C
T_soln = solve(eqn, symvar(T));

% Get T
T = subs(T, T_soln);

%%%%%%%%%
% Calculate E = TB
%%%%%%%%%

E = T * B

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

C_T_matrix = [C; T;];
C_T_matrix_inv = inv(C_T_matrix)

x_est = inv(C_T_matrix) * [y; xi;]

