import os
from ortools.linear_solver.python import model_builder, model_builder_helper

def main():
  solver_name = 'GLOP'
  path = os.path.dirname(os.path.abspath(__file__))
  print("path:", path)
  mps_path = f"{path}/maros-r7.mps"
  # mps_path = "./maros-r7.mps"
  
  print(mps_path)
o
  with open(mps_path, 'r') as file:
    data = file.read()

  model = model_builder_helper.ModelBuilderHelper()

  # Load MPS file.
  if not model.import_from_mps_file(mps_path):
      print(f'Cannot import MPS file: \'{mps_path}\'')
      return

  # Create solver.
  solver = model_builder.ModelSolver(solver_name)
  if not solver.solver_is_supported():
      print(f'Cannot create solver with name \'{solver_name}\'')
      return

  # # Set parameters.
  # if _PARAMS.value:
  #     solver.set_solver_specific_parameters(_PARAMS.value)

  # Enable the output of the solver.
  solver.enable_output(True)

  # And solve.
  solver.solve(model)

if __name__ == "__main__":
   main()