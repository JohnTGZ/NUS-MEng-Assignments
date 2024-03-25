clear; 
clc;

% xi = 0.95; % xi
% w = 10;  % Omega
% % x_m_dot = A_m*x_m + g_m*b*u
% Am = [0    1; 
%       -w^2 -2*xi*w];
% gm = [0; w^2];
% 
% A_eigenvalues = eig(Am)


%%%%%%%%%
% Determine natural frequency from rise time
%%%%%%%%%
t_r = 0.2 
w_n = 1.8 / t_r


%%%%%%%%%
% Plot curve of overshoot against damping ratio
%%%%%%%%%

M_p = [];
xi = 0.0:0.01:1.0;

for xi_ = xi
    M_p = [M_p, exp((-pi*xi_)/sqrt(1-xi_^2))];
end  

figure
hold on 
plot(xi, M_p, 'bx')
grid on
xlabel('$\xi$','interpreter','latex')
ylabel('$M_p$','interpreter','latex')
axis([0,1.0,0,1])
hold off


