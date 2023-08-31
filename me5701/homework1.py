from math import *

import numpy as np
from fractions import Fraction

def proj(u_in, a_in):
    """
    Project a onto u
    Only works for 1d arrays
    """
    u = u_in.flatten()
    a = a_in.flatten()

    return (np.dot(u, a) / np.dot(u, u)) * u_in

A = np.array([
    [1,2,3], 
    [3,1,5], 
    [7,8,1]
])

# A = np.array([
#     [12, -51, 4], 
#     [6,  167, -68], 
#     [-4, 24, -41]
# ])

# A = np.array([
#     [1, 1, 0], 
#     [1,  0, 1], 
#     [0, 1, 1]
# ])

a1 = A[:, [0]]
a2 = A[:, [1]]
a3 = A[:, [2]]

u1 = a1
u2 = a2 - proj(u1, a2)
u3 = a3 - proj(u1, a3) - proj(u2, a3)

# print(f"u1: {u1}")
# print(f"u2: {u2}")
# print(f"u2: {u3}")

e1 = u1 / np.linalg.norm(u1)
e2 = u2 / np.linalg.norm(u2)
e3 = u3 / np.linalg.norm(u3)

# print(f"e1: {e1}")
# print(f"e2: {e2}")
# print(f"e2: {e3}")

# a = np.concatenate((a1, a2, a3), axis=1)
Q = np.concatenate((e1, e2, e3), axis=1)

print(f"Q: {Q}")

R = Q.T @ A

print(f"R: {R}") 

# My manual calculations
# u_manual = np.array([
#     [1, 57/59 ],
#     [3, -124/59 ],
#     [7, 45/59 ],
# ])

# print(f"u_manual: {u_manual}")

# a = 3*59*20650 - 25*20650*1 + 404*57
# b = 5*59*20650 - 25*20650*3 - 404*124
# c = 1*59*20650 - 25*20650*7 + 404*45

# print(f"a: {Fraction(a, 20650)}")
# print(f"a: {Fraction(b, 20650)}")
# print(f"a: {Fraction(c, 20650)}")