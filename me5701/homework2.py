from math import *

import numpy as np
import matplotlib.pyplot as plt

# With reference to http://silas.psfc.mit.edu/22.15/lectures/chap1.xml

def constructA(x_data_pts, order=None):
  """Construct the A matrix for polynomial fitting in the form "Ax = b"

  Args:
      x_data_pts (np.array): x data points
      order (int, optional): Highest order in the polynomial to fit. Defaults to None.

  Returns:
      np.array: Matrix A of the form Sc = b
  """
  n = len(x_data_pts)

  if order is None:
    order = n-1

  A = np.ndarray((n, order+1))

  # For each row
  for i in np.arange(0,n):
    # For each column
    for j in np.arange(0,order+1):
      A[i, j] = x_data_pts[i]**j

  return A

def evalPolynomial(coeffs, x):
  """Evaluate value of polynomial in the form "c_0 + c_1 * x + ... c_n * x^n"

  Args:
      coeffs (array): Value of coefficients
      x (float): Value of x

  Returns:
      float: polynomial value
  """
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

A = constructA(x_data_pts)

print(A)

A_inv = np.linalg.inv(A)

print("A_inv: ", A_inv)

# Solve for coefficients. 
# A * coeffs = y_data_pts 
coeffs = A_inv @ y_data_pts

print("coeffs: ", coeffs)

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_1 = np.array([evalPolynomial(coeffs, x) for x in xp])

plt.show()

######
# Part b
######
print(f"\n")
print(f"Part b")
print(f"\n")

# obtain the best fit parabola y = ax**2 + bx + c
# Construct A up to the 2nd power
A = constructA(x_data_pts, 2)

print(A.shape)

M = np.identity(A.shape[0])
A_left_inv = getLeftWeightedInverse(A, M)

print(f"{A_left_inv.shape} * {y_data_pts.shape}")

# Solve for coefficients. 
# A * coeffs = y_data_pts  
coeffs_2 = A_left_inv @ y_data_pts

print(f"coeffs_2 = {coeffs_2}")

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_2 = np.array([evalPolynomial(coeffs_2, x) for x in xp])

######
# Part c
######
print(f"\n")
print(f"Part c")
print(f"\n")

# obtain the best fit parabola y = g(x) = ax**4 + bx**3 + cx**2 + dx + e
# while minimizing the cost C0(a,b,c,d,e) = integrate_over_-2_to_1 ( (g(x)**2) w.r.t dx)

# Weight matrix W obtained from file "./weights_calculation.ipynb"
W = np.array([
  [57,      -255/8,   129/7,    -21/2,    33/5],
  [-255/8,  129/7,    -21/2,    33/5,     -15/4,],
  [129/7,   -21/2,    33/5,     -15/4,    3],
  [-21/2,    33/5,    -15/4,     3,       -3/2],
  [33/5,    -15/4,    3,        -3/2,     3],
])

# Construct A up to the 4th power
A = constructA(x_data_pts, 4)
print(f"A shape: {A.shape}")

A_right_inv = getRightWeightedInverse(A, W)

# Solve for coefficients. 
# A * coeffs = y_data_pts 
coeffs_3 = A_right_inv @ y_data_pts

print(f"coeffs_3 = {coeffs_3}")

# Evaluate polynomial values for plotting
xp = np.linspace(-5, 5, 100)
yp_3 = np.array([evalPolynomial(coeffs_3, x) for x in xp])

######
# Part d
######

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


