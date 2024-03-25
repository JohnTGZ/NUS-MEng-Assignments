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
Dimension   : 1151 x 2763
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 1151 rows, 2763 columns and 8178 nonzeros
Model fingerprint: 0x7169fc8a
Coefficient statistics:
  Matrix range     [6e-03, 2e+00]
  Objective range  [7e+00, 6e+03]
  Bounds range     [0e+00, 0e+00]
  RHS range        [9e-03, 3e+01]
Iteration    Objective       Primal Inf.    Dual Inf.      Time
       0    9.2647269e+04   1.713653e+03   1.539382e+08      0s
     705    1.4892361e+06   0.000000e+00   0.000000e+00      0s

Solved in 705 iterations and 0.02 seconds (0.00 work units)
Optimal objective  1.489236134e+06
I0000 00:00:1710414973.830154   31041 program.cpp:197] objective = 1.48924e+06
Status      : MPSOLVER_OPTIMAL
Objective   : 1.489236134406133e+06
BestBound   : 1.489236134406133e+06
Wall Time   : 0.0366 s
User Time   : 0.03661 s

# Interior Point
Set parameter Method to value 2
Set parameter Threads to value 1
Set parameter DisplayInterval to value 1
Set parameter Presolve to value 0
Set parameter NetworkAlg to value 0
Set parameter Crossover to value 0
Set parameter BarConvTol to value 1e-06
Solver      : GUROBI_LINEAR_PROGRAMMING
Dimension   : 1151 x 2763
Gurobi Optimizer version 10.0.3 build v10.0.3rc0 (linux64)

CPU model: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz, instruction set [SSE2|AVX|AVX2]
Thread count: 6 physical cores, 12 logical processors, using up to 1 threads

Optimize a model with 1151 rows, 2763 columns and 8178 nonzeros
Model fingerprint: 0x7169fc8a
Coefficient statistics:
  Matrix range     [6e-03, 2e+00]
  Objective range  [7e+00, 6e+03]
  Bounds range     [0e+00, 0e+00]
  RHS range        [9e-03, 3e+01]
Ordering time: 0.00s

Barrier statistics:
 AA' NZ     : 5.345e+03
 Factor NZ  : 1.318e+04 (roughly 2 MB of memory)
 Factor Ops : 2.513e+05 (less than 1 second per iteration)
 Threads    : 1

                  Objective                Residual
Iter       Primal          Dual         Primal    Dual     Compl     Time
   0   4.35696306e+07  0.00000000e+00  4.63e+03 0.00e+00  8.25e+04     0s
   1   1.18906992e+07  1.76197755e+05  8.41e+02 1.82e+02  1.76e+04     0s
   2   3.95992543e+06  7.99252686e+05  3.31e+01 5.07e+00  1.58e+03     0s
   3   1.85530907e+06  1.21936484e+06  3.29e+00 1.02e-12  2.52e+02     0s
   4   1.79302753e+06  1.32252947e+06  2.69e+00 9.09e-13  1.82e+02     0s
   5   1.72678482e+06  1.35927948e+06  2.03e+00 9.09e-13  1.40e+02     0s
   6   1.67798879e+06  1.42953611e+06  1.58e+00 4.55e-13  9.38e+01     0s
   7   1.61793811e+06  1.46541250e+06  1.05e+00 9.09e-13  5.69e+01     0s
   8   1.51813681e+06  1.48038714e+06  1.78e-01 9.09e-13  1.37e+01     0s
   9   1.49917217e+06  1.48569806e+06  5.51e-02 9.09e-13  4.85e+00     0s
  10   1.49303638e+06  1.48800779e+06  2.00e-02 9.09e-13  1.81e+00     0s
  11   1.49088948e+06  1.48854197e+06  8.32e-03 9.09e-13  8.44e-01     0s
  12   1.48952725e+06  1.48916074e+06  1.30e-03 9.09e-13  1.32e-01     0s
  13   1.48925343e+06  1.48923336e+06  6.48e-05 9.09e-13  7.22e-03     0s
  14   1.48923632e+06  1.48923612e+06  5.65e-07 1.02e-12  7.17e-05     0s
  15   1.48923613e+06  1.48923613e+06  4.58e-10 9.09e-13  1.04e-08     0s

Barrier solved model in 15 iterations and 0.01 seconds (0.01 work units)
Optimal objective 1.48923613e+06

I0000 00:00:1710414912.944628   30919 program.cpp:197] objective = 1.48924e+06
Status      : MPSOLVER_OPTIMAL
Objective   : 1.489236134421737e+06
BestBound   : 1.489236134421737e+06
Wall Time   : 0.0121 s
User Time   : 0.0121 s