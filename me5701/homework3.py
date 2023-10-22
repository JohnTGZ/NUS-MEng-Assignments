from math import *

import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

def pend(y, t, constants):
    x1, y1, x2, y2 = y

    m1 = constants["m1"]
    m2 = constants["m2"]
    k1 = constants["k1"]
    k2 = constants["k2"]
    c1 = constants["c1"]
    c2 = constants["c2"]
    u = constants["u"]

    dydt = [x2, 
            y2,     
            ((-k1-k2)*x1 + k2*y1 + (-c1-c2)*x2 + c2*y2)/m1, 
            (k2*x1 + (-k2)*y1 + c2*x2 + (-c2)*y2)/m2 - u/m2, 
            ]
    return dydt

def plot_soln(ax, soln, t, title="untitled"):
    ax.set_title(title)
    ax.plot(t, soln[:, 0], 'b', label='q1 [m]')
    ax.plot(t, soln[:, 1], 'g', label='q1_dot [m/s]')
    ax.plot(t, soln[:, 2], 'r', label='q2 [m]')
    ax.plot(t, soln[:, 3], 'y', label='q2_dot [m/s]')
    ax.legend(loc='best')
    ax.set_ylabel('State variables')
    ax.set_xlabel('t', labelpad=10, fontsize=12, color='green')
    ax.grid()

constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 1, "c2": 2,
    "u": 0,
}

# Initial conditions
# y0 = [q1, q1_dot, q2, q2_dot] 
y0 = [0, 0, 0, 0]
# Time boundary
t_lim = np.linspace(0, 30, 101)

#####
# Solution 1: U = 0, q1(0) = 2
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 1, "c2": 2,
    "u": 0,
}
y0 = [2, 0, 0, 0]

soln_1 = odeint(pend, y0, t_lim, args=(constants,))

#####
# Solution 2: U = 0, q1(0) = 2, c2 = 10
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 1, "c2": 2,
    "u": 0,
}
y0 = [2, 0, 0, 0]

soln_2 = odeint(pend, y0, t_lim, args=(constants,))

#####
# Solution 3: U = 0, q1(0) = 2, c1=-1
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 1, "c2": 2,
    "u": 0,
}
y0 = [2, 0, 0, 0]

soln_3 = odeint(pend, y0, t_lim, args=(constants,))

#####
# Solution 4: U = 1, default parameters
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 2, "k2": 1,
    "c1": 1, "c2": 2,
    "u": 1,
}
y0 = [0, 0, 0, 0]

soln_4 = odeint(pend, y0, t_lim, args=(constants,))

#####
# Solution 5: U = 1, c2 = 10
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 1, "c2": 10,
    "u": 1,
}
y0 = [0, 0, 0, 0]

soln_5 = odeint(pend, y0, t_lim, args=(constants,))

#####
# Solution 6: U = 1, c1 = 0.1. Underdamped?
#####
constants = {
    "m1": 2, "m2": 1,
    "k1": 1, "k2": 1,
    "c1": 0.1, "c2": 2,
    "u": 1,
}
y0 = [0, 0, 0, 0]

soln_6 = odeint(pend, y0, t_lim, args=(constants,))

fig, axs = plt.subplots(3,2)

plot_soln(axs[0,0], soln_1, t_lim, "U = 0, q1(0) = 2, Default parameters")
plot_soln(axs[1,0], soln_2, t_lim, "U = 0, q1(0) = 2, c2 = 10. Overdamped?")
plot_soln(axs[2,0], soln_3, t_lim, "U = 0, q1(0) = 2, c1 = -1. Unstable!")

plot_soln(axs[0,1], soln_4, t_lim, "U = 1, default parameters")
plot_soln(axs[1,1], soln_5, t_lim, "U = 1, c2 = 10. Overdamped?")
plot_soln(axs[2,1], soln_6, t_lim, "U = 1, c1 = 0.1. Underdamped?")

plt.show()