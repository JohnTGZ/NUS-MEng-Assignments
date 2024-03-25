# Problem sets 
rows are constraints (m), this is the number of basic variables
columns are variables (n)

non-basic variables = n-m
Number of basic feasible solutions =  n choose m 

Name       Rows(m)   Cols(n)   Nonzeros    Bytes  BR      Optimal Value      Num non-Basic(n-m)
SHIP12S    1152      2763       10941      82527        1.4892361344E+06      1611
SHIP12L    1152      5427       21597     146753        1.4701879193E+06      4275
GREENBEB   2393      5405       31499     235739  B    -4.3022602612E+06      3012


[netlib](https://www.netlib.org/lp/data/)

# Pulp

## Decompressing MPSC files
```bash
./emps.sh
./a.out maros-r7.mpsc >> maros-r7.mps
```

## Measuring runtime

https://docs.python.org/3/library/timeit.html#command-line-interface
```bash
python -m timeit  "$(cat mini_proj.py)"
python -m timeit -n 1  "$(cat mini_proj.py)"
```

## Profiling memory

### Python
```bash
python3 -m memory_profiler mini_proj.py
```

### Cpp
```bash
/usr/bin/time ./myapp
valgrind --leak-check=yes --track-origins=yes ./myapp
```

# OR-Tools

## Installation (OR-TOOLS)
1. Download binary distribution
2. Copy contents to `/usr/local`

## API
ortools/linear_solver/linear_solver.h
ortools/linear_solver/solve.cc

## Inspect proto messages
/home/john/apps/or-tools/ortools/linear_solver/linear_solver.proto









# WHAT IS PRESOLVING
https://support.gurobi.com/hc/en-us/articles/360024738352-How-does-presolve-work