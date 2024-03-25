import time
import pulp
from pulp import LpMaximize, LpMinimize, LpProblem
from memory_profiler import profile

@profile
def primalSimplex():
  variables, problem = LpProblem.fromMPS("./data/s250r10.mps",sense=LpMinimize)
  result = problem.solve(pulp.apis.PULP_CBC_CMD( msg=1, threads=1, timeMode='cpu', options=['primalSimplex']))

@profile
def barrier():
  variables, problem = LpProblem.fromMPS("./data/s250r10.mps",sense=LpMinimize)
  result = problem.solve(pulp.apis.PULP_CBC_CMD( msg=1, threads=1, timeMode='cpu', options=['barrier']))

def mainOG():
  # Optimal val: 1.4971851665E+06
  variables, problem = LpProblem.fromMPS("./data/greenbeb.mps",sense=LpMinimize)
  # variables, problem = LpProblem.fromMPS("./data/maros-r7.mps",sense=LpMinimize)

  # print(f"Number of variables: {len(variables)}")

  # t_a_proc = time.process_time()
  # t_a_perf = time.perf_counter()

  # https://coin-or.github.io/pulp/technical/solvers.html#pulp.apis.COIN_CMD 
  # Options: primalSimplex, dualSimplex, and barrier
  solver_choice = 'barrier'
  # solver_choice = 'primalSimplex'
  # solver_choice = 'dualSimplex'
  result = problem.solve(pulp.apis.PULP_CBC_CMD(msg=1, threads=1, timeMode='cpu', options=[solver_choice]))
  
  problem.writeMPS("greenbeb.mps")

  # t_b_proc = time.process_time()
  # t_b_perf = time.perf_counter()
  # print(f"CPU Time: {t_b_proc - t_a_proc}")
  # print(f"Wall Time: {t_b_perf - t_a_perf}")
  # print(f"result: {result}")

if __name__ == '__main__':  
    # primalSimplex()
    mainOG()
    # barrier()