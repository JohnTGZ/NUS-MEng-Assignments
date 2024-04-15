clear; 
clc;

%%%%%
% Simulation params
%%%%%
samp_t = 1;

%%%%%
% Plant model
%%%%%
% site 1
a_1 = 0.9897;
b_1 = 0.05263;
d_1 = 15;

kc_1 = 1; % Proportional gain
kI_1 = 1; % Integral gain

% Hyperparameters
step_i = 0.1 % Step size
N = 20 % Sample size

pd_y_rho = 

R_i = (1/N) * 
pd_J_rho = (1/N) * 

rho_next = rho_i - step_i * inv(R_i) * pd_J_rho