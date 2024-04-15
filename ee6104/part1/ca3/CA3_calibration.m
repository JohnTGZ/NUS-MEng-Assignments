% % Use linear model ang_pos = k * pot_out, where k is parameter to be
% % estimated
% % Potentiometer output
% pot_out = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]
% % Angular position
% ang_pos = [-180, -144, -108, -72, -36, 0, 36, 72, 108, 144, 180]
% mdl = fitlm(pot_out, ang_pos, 'intercept', false);
% fprintf('The estimation of the parameter is: %d.\n',mdl.Coefficients{1,1})
% 
% figure
% hold on 
% plot(pot_out, ang_pos, 'bx')
% plot(pot_out,mdl.Fitted,'r-')
% grid on
% xlabel('Potentiometer Output$(V)$','interpreter','latex')
% ylabel('Angular Position $(degrees)$','interpreter','latex')
% axis([-5,5,-185,180])
% hold off

% Use linear model ang_pos = k * pot_out, where k is parameter to be
% estimated
% Voltage input
% tach_out = [-4.03, -3.17,  -2.3,   -1.45,   -0.6, 0, 0.62, 1.48,  2.33,  3.2,   4.06]

% Voltage input
tach_out = [-40.3, -31.7,  -23,   -14.5,   -6, 0, 6.2, 14.8,  23.3,  32,   40.6] 

% Tachometer output
ang_vel = [-31.52, -24.82, -18.01, -11.31, -4.71, 0, 5.03, 11.62, 18.33, 25.03, 31.73 ]
% ang_vel = [-5, -4, -3, -2, -1, 0, 1, 2, 3, 4, 5]

mdl = fitlm(tach_out, ang_vel, 'intercept', false);
fprintf('The estimation of the parameter is: %d.\n',mdl.Coefficients{1,1})

figure
hold on 
plot(tach_out, ang_vel, 'bx')
plot(tach_out, mdl.Fitted,'r-')
grid on
xlabel('Tachogenerator Output$(V)$','interpreter','latex')
ylabel('Angular Velocity $(rad s^{-1})$','interpreter','latex')
axis([-50,50,-40,40])
hold off
