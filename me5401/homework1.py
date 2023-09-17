from math import *

import numpy as np
import matplotlib.pyplot as plt

A = np.array([
  [-4, 1, 0],
  [0,  -3, 1],
  [0, 0, -2],
])

eigenvalues, eigenvectors = np.linalg.eig(A)

print("A: ")
print("Eigenvalues: ", eigenvalues)
print("eigenvectors: ", eigenvectors)

# Question 5

B = np.array([
  [1, 3],
  [2, 4],
])


eigenvalues, eigenvectors = np.linalg.eig(B)

print("B: ")
print("Eigenvalues: ", eigenvalues)
print("eigenvectors: ", eigenvectors)