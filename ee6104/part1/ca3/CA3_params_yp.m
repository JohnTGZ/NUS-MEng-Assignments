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

%%%%%
% Integral control of angular velocity
%%%%%

%A
% gamma_y = 1;
% gamma_r = 1;

%B
% gamma_y = 10;
% gamma_r = 10;

%C
gamma_y = 25;
gamma_r = 25;

