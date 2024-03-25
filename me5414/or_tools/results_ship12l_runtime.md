# Optimal value
https://www.netlib.org/lp/data/readme

Name       Rows   Cols   Nonzeros    Bytes  BR      Optimal Value
SHIP12L    1152   5427    21597     146753        1.4701879193E+06
SHIP12S    1152   2763    10941      82527        1.4892361344E+06

# Primal simplex
Set parameter Method to value 0
Set parameter Threads to value 1
Set parameter DisplayInterval to value 1
Set parameter Presolve to value 0
Set parameter NetworkAlg to value 0
Set parameter Crossover to value 0
Set parameter BarConvTol to value 1e-06
Solver      : GUROBI_LINEAR_PROGRAMMING
Dimension   : 1151 x 5427
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 1151 rows, 5427 columns and 16170 nonzeros
Model fingerprint: 0xb6c4bbab
Coefficient statistics:
  Matrix range     [6e-03, 2e+00]
  Objective range  [7e+00, 6e+03]
  Bounds range     [0e+00, 0e+00]
  RHS range        [9e-03, 3e+01]
Iteration    Objective       Primal Inf.    Dual Inf.      Time
       0   -1.7001794e+04   1.410987e+03   1.229406e+08      0s
    1532    1.4701879e+06   0.000000e+00   0.000000e+00      0s

Solved in 1532 iterations and 0.01 seconds (0.01 work units)
Optimal objective  1.470187919e+06
I0000 00:00:1710413851.153669   30277 program.cpp:197] objective = 1.47019e+06
Status      : MPSOLVER_OPTIMAL
Objective   : 1.470187919329266e+06
          OPT(1.4701879193E+06)
BestBound   : 1.470187919329266e+06
Wall Time   : 0.01347 s
User Time   : 0.01348 s
StatusString: 

# Interior Point
Set parameter Method to value 2
Set parameter Threads to value 1
Set parameter DisplayInterval to value 1
Set parameter Presolve to value 0
Set parameter NetworkAlg to value 0
Set parameter Crossover to value 0
Set parameter BarConvTol to value 1e-06
Solver      : GUROBI_LINEAR_PROGRAMMING
Dimension   : 1151 x 5427
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 1151 rows, 5427 columns and 16170 nonzeros
Model fingerprint: 0xb6c4bbab
Coefficient statistics:
  Matrix range     [6e-03, 2e+00]
  Objective range  [7e+00, 6e+03]
  Bounds range     [0e+00, 0e+00]
  RHS range        [9e-03, 3e+01]
Ordering time: 0.00s

Barrier statistics:
 AA' NZ     : 1.067e+04
 Factor NZ  : 1.808e+04 (roughly 3 MB of memory)
 Factor Ops : 4.343e+05 (less than 1 second per iteration)
 Threads    : 1

                  Objective                Residual
Iter       Primal          Dual         Primal    Dual     Compl     Time
   0   8.84384893e+07  0.00000000e+00  7.44e+03 0.00e+00  8.34e+04     0s
   1   2.04123563e+07  1.64188177e+05  1.37e+03 1.84e+02  1.69e+04     0s
   2   4.32606467e+06  7.54230587e+05  5.57e+01 7.64e+00  1.19e+03     0s
   3   2.00965153e+06  1.12270939e+06  7.11e+00 9.09e-13  2.13e+02     0s
   4   1.79251214e+06  1.35309359e+06  3.98e+00 4.55e-13  9.94e+01     0s
   5   1.67804503e+06  1.40507610e+06  2.43e+00 1.14e-12  5.97e+01     0s
   6   1.64218091e+06  1.43369134e+06  1.96e+00 9.09e-13  4.50e+01     0s
   7   1.57501000e+06  1.45441064e+06  1.14e+00 4.55e-13  2.54e+01     0s
   8   1.49931624e+06  1.46405575e+06  2.56e-01 7.96e-13  7.10e+00     0s
   9   1.47829298e+06  1.46800594e+06  6.13e-02 9.09e-13  2.02e+00     0s
  10   1.47291120e+06  1.46936201e+06  1.86e-02 1.36e-12  6.91e-01     0s
  11   1.47088683e+06  1.46993681e+06  4.14e-03 4.55e-13  1.84e-01     0s
  12   1.47032957e+06  1.47012172e+06  8.11e-04 5.68e-13  4.00e-02     0s
  13   1.47019609e+06  1.47018446e+06  1.86e-05 1.14e-12  2.16e-03     0s
  14   1.47018893e+06  1.47018791e+06  2.17e-06 6.82e-13  1.92e-04     0s
  15   1.47018792e+06  1.47018792e+06  1.19e-09 1.36e-12  3.83e-08     0s

Barrier solved model in 15 iterations and 0.04 seconds (0.02 work units)
Optimal objective 1.47018792e+06
                  
I0000 00:00:1710414000.203936   30464 program.cpp:197] objective = 1.47019e+06
Status      : MPSOLVER_OPTIMAL
Objective   : 1.470187919520708e+06
          OPT(1.4701879193E+06)
BestBound   : 1.470187919520708e+06
Wall Time   : 0.0596 s
User Time   : 0.05961 s

