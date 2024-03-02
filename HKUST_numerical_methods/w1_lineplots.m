clear all; close all; clc;
theta = linspace(0, 2*pi);
x = cos(theta);
y = sin(theta);
plot(x, y);
axis equal;
axis([-1.1 1.1 -1.1 1.1]);
ax = gca; %GEt curent axis
ax.XTick=[-1 -0.5 0 0.5 1];
ax.YTick=[-1 -0.5 0 0.5 1];
xlabel('$x$', 'Interpreter', 'latex', 'FontSize',14);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize',14);
title('Plot of a circle', 'Interpreter','latex','FontSize',16);