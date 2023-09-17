from math import *

import numpy as np
import matplotlib.pyplot as plt

# With reference to http://silas.psfc.mit.edu/22.15/lectures/chap1.xml

def construct_S(x_data_pts, order=None):
  """_summary_

  Args:
      x_data_pts (np.array): x data points
      order (int, optional): Highest order in the polynomial to fit. Defaults to None.

  Returns:
      np.array: Matrix S of the form Sc = b
  """
  n = len(x_data_pts)

  if order is None:
    order = n-1

  S = np.ndarray((n, order+1))

  # For each row
  for i in np.arange(0,n):
    # For each column
    for j in np.arange(0,order+1):
      S[i, j] = x_data_pts[i]**j

  return S

def eval_polynomial(coeffs, x):
  val = 0
  for i in range(0, len(coeffs)):
    val += coeffs[i] * (x ** i)
  return val

def getLeftWeightedInverse(A, W):
  """Get left weighted pseudoinverse. Returns pseudoinverse of matrix A, A_W_inv
  which is of the form, x = A_W_inv * b.
  For over-constrained problems m > n

  Args:
      A (np.array): Matrix of the form Ax = b
      W (np.array): Weights, choosen to be positive definite

  Returns:
      np.array: Left weighted inverse
  """
  
  return np.linalg.inv(A.T @ W @ A) @ A.T @ W

def getRightWeightedInverse(A, W):
  """Get right weighted pseudoinverse. Returns pseudoinverse of matrix A, A_W_inv, 
  which is of the form, x = A_W_inv * b.
  For under-constrained problems where n > m.

  Args:
      A (np.array): Matrix of the form Ax = b
      W (np.array): Weights, choosen to be positive definite

  Returns:
      np.array: Right weighted inverse
  """
  W_inv = np.linalg.inv(W)

  
  return W_inv @ A.T @ np.linalg.inv(A @ W_inv @ A.T)

x_data_pts = np.array([0, 1, -1, -2])
y_data_pts = np.array([0, 1, 0.5, 4])

######
# Part A
######
print(f"\n")
print(f"Part a")
print(f"\n")

S = construct_S(x_data_pts)

print(S)

S_inv = np.linalg.inv(S)

print("S_inv: ", S_inv)

# Solve for coefficients. S * c = y_data_pts  
coeffs = S_inv @ y_data_pts

print("coeffs: ", coeffs)

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_1 = np.array([eval_polynomial(coeffs, x) for x in xp])

plt.show()

######
# Part b
######
print(f"\n")
print(f"Part b")
print(f"\n")

# obtain the best fit parabola y = ax**2 + bx + c
# Construct S up to the 2nd power
S = construct_S(x_data_pts, 2)

print(S.shape)

M = np.identity(S.shape[0])
S_left_inv = getLeftWeightedInverse(S, M)

print(f"{S_left_inv.shape} * {y_data_pts.shape}")

coeffs_2 = S_left_inv @ y_data_pts

print(f"coeffs_2 = {coeffs_2}")

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_2 = np.array([eval_polynomial(coeffs_2, x) for x in xp])

######
# Part c
######
print(f"\n")
print(f"Part c")
print(f"\n")

# obtain the best fit parabola y = g(x) = ax**4 + bx**3 + cx**2 + dx + e
# while minimizing the cost C0(a,b,c,d,e) = integrate_over_-2_to_1 ( (g(x)**2) w.r.t dx)

# Minimize cost from x=-2 to x=1?
# First we do d/dx(c0) = 0
W = np.array([
  [57,      -255/8,   129/7,    -21/2,    33/5],
  [-255/8,  129/7,    -21/2,    33/5,     -15/4,],
  [129/7,   -21/2,    33/5,     -15/4,    3],
  [-21/2,    33/5,    -15/4,     3,       -3/2],
  [33/5,    -15/4,    3,        -3/2,     3],
])

# Construct S up to the 4th power
S = construct_S(x_data_pts, 4)
print(f"S shape: {S.shape}")

S_right_inv = getRightWeightedInverse(S, W)

coeffs_3 = S_right_inv @ y_data_pts

print(f"coeffs_3 = {coeffs_3}")

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_3 = np.array([eval_polynomial(coeffs_3, x) for x in xp])

######
# Plotting
######

# TODO Space out the plots

fig, axs = plt.subplots(3, 1)
axs[0].set_title("Q1: Polynomial fitting")
axs[0].plot(xp, yp_1, '-', color='green')
axs[0].plot(x_data_pts, y_data_pts, '.', color='red')

axs[1].set_title("Q2: Overconstrained Fitting ")
axs[1].plot(xp, yp_2, '-', color='green')
axs[1].plot(x_data_pts, y_data_pts, '.', color='red')

axs[2].set_title("Q3: Underconstrained (4th order polynomial fitting) ")
axs[2].plot(xp, yp_3, '-', color='green')
axs[2].plot(x_data_pts, y_data_pts, '.', color='red')

plt.show()

######
# Part c
######


