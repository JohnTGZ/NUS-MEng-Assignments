# Optimal value
https://www.netlib.org/lp/data/readme

Name       Rows   Cols   Nonzeros    Bytes  BR      Optimal Value
GREENBEB   2393   5405    31499     235739  B    -4.3021476065E+06

# Primal simplex
Set parameter Method to value 0
Set parameter Threads to value 1
Set parameter DisplayInterval to value 1
Set parameter Presolve to value 0
Set parameter NetworkAlg to value 0
Set parameter Crossover to value 0
Set parameter BarConvTol to value 1e-06
Solver      : GUROBI_LINEAR_PROGRAMMING
Dimension   : 2392 x 5405
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 2392 rows, 5405 columns and 30877 nonzeros
Model fingerprint: 0x5b8a6179
Coefficient statistics:
  Matrix range     [6e-05, 1e+02]
  Objective range  [6e-02, 1e+02]
  Bounds range     [1e+00, 1e+04]
  RHS range        [0e+00, 0e+00]
Iteration    Objective       Primal Inf.    Dual Inf.      Time
       0   -6.4808227e+05   9.530718e+03   4.428469e+08      0s
    5846   -4.3022603e+06   0.000000e+00   0.000000e+00      0s

Solved in 5846 iterations and 0.43 seconds (0.30 work units)
Optimal objective -4.302260261e+06
I0000 00:00:1710518096.018571    9603 program.cpp:198] objective = -4.30226e+06
Status      : MPSOLVER_OPTIMAL
Objective   : -4.302260261206587e+06
BestBound   : -4.302260261206587e+06
Wall Time   : 0.4528 s
User Time   : 0.4528 s

# Interior Point
Set parameter Method to value 2
Set parameter Threads to value 1
Set parameter DisplayInterval to value 1
Set parameter Presolve to value 0
Set parameter NetworkAlg to value 0
Set parameter Crossover to value 0
Set parameter BarConvTol to value 1e-06
Solver      : GUROBI_LINEAR_PROGRAMMING
Dimension   : 2392 x 5405
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 2392 rows, 5405 columns and 30877 nonzeros
Model fingerprint: 0x5b8a6179
Coefficient statistics:
  Matrix range     [6e-05, 1e+02]
  Objective range  [6e-02, 1e+02]
  Bounds range     [1e+00, 1e+04]
  RHS range        [0e+00, 0e+00]
Ordering time: 0.01s

Barrier statistics:
 Free vars  : 3
 AA' NZ     : 3.384e+04
 Factor NZ  : 9.627e+04 (roughly 4 MB of memory)
 Factor Ops : 5.786e+06 (less than 1 second per iteration)
 Threads    : 1

                  Objective                Residual
Iter       Primal          Dual         Primal    Dual     Compl     Time
   0  -1.68858052e+08 -1.82800490e+07  1.85e+05 4.35e+02  1.01e+06     0s
   1  -1.03842429e+08 -2.64208717e+07  1.00e+05 3.76e+02  5.53e+05     0s
   2  -6.51179793e+07 -3.78698275e+07  5.47e+04 1.52e+02  2.99e+05     0s
   3  -3.24428164e+07 -4.55689916e+07  2.41e+04 3.91e+01  1.34e+05     0s
   4  -9.90872646e+06 -3.82486492e+07  4.91e+03 1.71e+01  3.22e+04     0s
   5  -5.46094494e+06 -2.30443298e+07  1.39e+03 3.93e+00  1.02e+04     0s
   6  -4.44986082e+06 -1.21516471e+07  5.48e+02 9.45e-01  3.84e+03     0s
   7  -4.06565813e+06 -8.87914722e+06  1.55e+02 4.54e-01  1.50e+03     0s
   8  -4.04222388e+06 -6.51694498e+06  6.61e+01 1.87e-01  6.69e+02     0s
   9  -4.10027032e+06 -5.33559890e+06  2.87e+01 6.56e-02  3.05e+02     0s
  10  -4.14928555e+06 -4.91098742e+06  1.81e+01 4.86e-02  1.86e+02     0s
  11  -4.20917878e+06 -4.72621397e+06  1.04e+01 2.34e-02  1.19e+02     0s
  12  -4.24538449e+06 -4.50106710e+06  4.31e+00 1.04e-02  5.60e+01     0s
  13  -4.25728616e+06 -4.46014101e+06  3.25e+00 8.00e-03  4.39e+01     0s
  14  -4.26965842e+06 -4.39998033e+06  2.20e+00 4.81e-03  2.85e+01     0s
  15  -4.28488414e+06 -4.35028570e+06  1.03e+00 2.15e-03  1.42e+01     0s
  16  -4.29465260e+06 -4.32603864e+06  4.88e-01 9.17e-04  6.91e+00     0s
  17  -4.29664749e+06 -4.31946923e+06  3.92e-01 7.09e-04  5.50e+00     0s
  18  -4.29509964e+06 -4.31442042e+06  2.60e-01 5.86e-04  4.59e+00     0s
  19  -4.29726917e+06 -4.30737336e+06  1.61e-01 2.75e-04  2.53e+00     0s
  20  -4.29953627e+06 -4.30393161e+06  7.33e-02 9.23e-05  1.12e+00     0s
  21  -4.30078308e+06 -4.30304169e+06  3.61e-02 4.17e-05  5.70e-01     0s
  22  -4.30163275e+06 -4.30262628e+06  1.32e-02 1.78e-05  2.38e-01     0s
  23  -4.30186323e+06 -4.30244829e+06  8.20e-03 8.82e-06  1.43e-01     0s
  24  -4.30199049e+06 -4.30236424e+06  5.48e-03 4.66e-06  9.29e-02     0s
  25  -4.30214107e+06 -4.30232095e+06  2.22e-03 2.69e-06  4.26e-02     0s
  26  -4.30221417e+06 -4.30229554e+06  7.61e-04 1.57e-06  1.80e-02     0s
  27  -4.30224106e+06 -4.30227686e+06  2.97e-04 6.98e-07  7.74e-03     0s
  28  -4.30225804e+06 -4.30226316e+06  2.54e-05 1.15e-07  1.01e-03     0s
  29  -4.30226016e+06 -4.30226048e+06  7.67e-07 8.10e-09  5.96e-05     0s
  30  -4.30226026e+06 -4.30226027e+06  2.38e-08 4.35e-10  2.13e-06     0s
  31  -4.30226026e+06 -4.30226026e+06  9.93e-10 7.41e-11  2.70e-08     0s

Barrier solved model in 31 iterations and 0.24 seconds (0.11 work units)
Optimal objective -4.30226026e+06

I0000 00:00:1710518191.716846    9763 program.cpp:199] objective = -4.30226e+06
Status      : MPSOLVER_OPTIMAL
Objective   : -4.302260261098080e+06
BestBound   : -4.302260261098080e+06
Wall Time   : 0.2362 s
User Time   : 0.2362 s
