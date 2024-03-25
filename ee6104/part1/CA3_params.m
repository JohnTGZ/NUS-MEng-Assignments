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
% % Tune Gamma and gamma
% Gamma = [1 0; 
%          0  1];
% gamma = 10;
% 
% % Tune Q
% Q = [10 0; 
%       0 10];
% 
% P = lyap(Am', Q);

% Gamma = [10000 0;  0  7000];
% gamma = 1000;
% Q = [4000 0; 0 5];

% Start from default
% Gamma = [10 0; 
%          0  1];
% gamma = 10;
% Q = [100 0; 0 1];

% 1: Start from identity
% 2: increase Q_11 to 100
% 3: Increase Gamma_11: Increase in oscillation
% 4: Back to 2: Increase Gamma_22 to 200
% 5: Increase Q_11 to 500
% 6: Scale Gamma up to 10, 1000
% 7: Scale Gamma up to 50, 1000

% gamma increases the weight of the reference input relative to the error
% (Increase Q_22: Leads to faster change in x_m,2)

% Gamma = [30 0; 
%          0  450];
% gamma = 3;
% Q = [500 0; 0 1];

% Gamma = [100 0; 
%          0  300];
% gamma = 50;
% Q = [700 0; 0 10];

% Gamma = [200 0; 
%          0  300];
% gamma = 100;
% Q = [2000 0; 0 20];

% Gamma = [250 0; 
%          0  500];
% gamma = 125;
% Q = [3000 0; 0 40];


%%%%%
% Integral control of angular velocity
%%%%%

% Gamma = [1 0; 
%          0  5;
% gamma = 10;
% Q = [1 0; 0 15];

Gamma = [1 0;  0  400];
gamma = 50;
Q = [1 0; 0 100];

P = lyap(Am', Q);










