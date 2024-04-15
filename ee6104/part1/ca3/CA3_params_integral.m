clear; 
clc;

%%%%%%
% Plant parameters
%%%%%%
% x_p_dot = A_p*x_p + g*u
K = 6.2;        % rad s^-1 V^-1
tau = 0.25;     % seconds  

K_theta = 36; % Gains for potentiometer
K_w = 0.7827563;       % Gains for tachometer

ap = -1/tau;
g = K/tau;

%%%%%%
% Reference Model Params
%%%%%%
xi = 0.6; % xi
w = 7;  % Omega

% x_m_dot = A_m*x_m + g_m*r
am = -2 * xi * w;
gm = w^2;

Am_bar = [am gm; 
          1 0];

%%%%%
% Integral control of angular velocity
%%%%%
b_bar = [1; 0];

% Best lower params
gamma_y = 1.0;
gamma_I = 1.0;

Gamma = [gamma_y 0; 0  gamma_I];
Q = [1 0; 0 1];

P_bar = lyap(Am_bar, Q);




