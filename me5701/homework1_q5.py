from math import *

import numpy as np
import matplotlib.pyplot as plt

def todaMatrix(sz):
    A = np.zeros((sz, sz))

    for i in np.arange(0,sz,1):
        # Diagonals
        A[i, i] = 2

        # Super diagonals
        if i > 0:
            A[i-1, i] = -1
        
        # Sub diagonals
        if i > 0:
            A[i, i-1] = -1

    return A

def randomUnitVector(sz):
    u = np.random.rand(sz) 
    unit_u = u / np.linalg.norm(u)
    return unit_u

A = todaMatrix(100)
u_k = randomUnitVector(100)

k_range = np.arange(0, 100, 1)
c_k_arr = []
e_k_arr = []

for k in k_range:
    B = A @ u_k

    c_k = np.dot(u_k, B)
    c_k_arr.append(c_k)
    
    e_k = np.linalg.norm(c_k * u_k - B)
    e_k_arr.append(e_k)
    
    u_k = B / np.linalg.norm(B)

fig, ax = plt.subplots()

c_k_line, = ax.plot(k_range, c_k_arr, label='c_k')
e_k_line, = ax.plot(k_range, e_k_arr, label='e_k')
ax.legend(handles=[c_k_line, e_k_line])

plt.show()

