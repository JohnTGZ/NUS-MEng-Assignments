clear; 
clc;


%%%%%%
% Zeta and wn affects Tp
%%%%%%
zeta = 0.03;
wn = 5;

%%%%%%
% Gamma and gamma
%%%%%%
ga = 10;
Gamma = diag([ 10*ga, 10*ga, 10*ga, 10*ga, 10*ga]);

%%%%%%
% Plant parameters
%%%%%%
a1 = 0.22;
a2 = 6.1;
b0 = -0.5;
b1 = -1;
num = [b0 b1];
dem = [1 2*zeta*wn wn^2];
sys = tf(num,dem);

pole(sys);

% Zp (plant zero polynomial)
kp = b0;
Zp = [1 b1/b0];
% Rp (plant pole polynomial)
Rp = [1 a1 a2];

% Tp (observer polynomial)
Tp = [1 2*zeta*wn wn^2]

% Rm(reference model polynomial)
am = 3;
Rm = [1 am];
Km = am;

% E and F (T*Rm = Rp*E + F)
[E, F] = deconv(conv(Tp, Rm), Rp);

% Fbar, Gbar, and G1
Fbar = F/Kp;
Gbar = conv(E, Zp);
G1 = Gbar - Tp;
% Kstar
Kstar = Km/Kp;
% gains (Perfect gain)
theta_bar_star= [Kstar, -G1(3), G1(2), -Fbar(4), -Fbar(3)]





