import time
import pulp
from pulp import LpMaximize, LpMinimize, LpProblem


def main():
  variables, problem = LpProblem.fromMPS("./maros-r7.mps",sense=LpMinimize)

  # print(f"Number of variables: {len(variables)}")

  # t_a_proc = time.process_time()
  t_a_perf = time.perf_counter()

  # https://coin-or.github.io/pulp/technical/solvers.html#pulp.apis.COIN_CMD 
  # Options: primalSimplex, dualSimplex, and barrier
  result = problem.solve(pulp.apis.PULP_CBC_CMD(
    msg=1, threads=1, timeMode='cpu', options=['barrier']))

  # t_b_proc = time.process_time()
  t_b_perf = time.perf_counter()

  # print(f"CPU Time: {t_b_proc - t_a_proc}")
  print(f"Wall Time: {t_b_perf - t_a_perf}")

  # print(f"result: {result}")


if __name__ == '__main__':  
    main()