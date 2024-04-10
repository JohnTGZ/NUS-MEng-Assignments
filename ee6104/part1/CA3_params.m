clear; 
clc;

%%%%%%
% Plant parameters
%%%%%%

% x_p_dot = A_p*x_p + g*b*u
K = 6.2;        % rad s^-1 V^-1
tau = 0.25;     % seconds
b = [0; 
     1];    
g = K/tau;      

K_theta = 36; % Gains for potentiometer
K_w = 0.7827563;       % Gains for tachometer


%%%%%%
% Reference Model Params
%%%%%%
% xi = 0.83; % xi
% w = 18;  % Omega

% xi = 0.7; % xi
% w = 10;  % Omega

xi = 0.6; % xi
w = 7;  % Omega

% x_m_dot = A_m*x_m + g_m*b*u
Am = [0    1; 
      -w^2 -2*xi*w];
gm = [0; w^2];

%%%%%%
% Gamma and gamma
%%%%%%
% % Start from default
% Gamma = [10 0; 
%          0  1];
% gamma = 10;
% Q = [100 0; 0 1];

% Best lower params
% Gamma = [100 0; 0  2000]; gamma = 125;
% Q = [3000 0; 0 5];

% Values for testing
% Gamma = [500 0; 0 1000]; 
% gamma = 125;
% Q = [5000 0; 0 20];

%%%%%
% Integral control of angular velocity
%%%%%


Gamma = [0.01 0;  0  20];
gamma = 2;
Q = [0.1 0; 0 5];


% Gamma = [300 0; 
%          0  200];
% gamma = 50;
% Q = [5000 0; 0 150];

P = lyap(Am', Q);










