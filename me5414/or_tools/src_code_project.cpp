#include <iostream>
#include <memory>

#include "ortools/gurobi/environment.h"
#include "ortools/linear_solver/proto_solver/gurobi_proto_solver.h"
#include "ortools/linear_solver/linear_solver.h"
#include "ortools/lp_data/mps_reader.h"

namespace operations_research {

MPModelProto loadMPSFile(const std::string& mps_file){
  absl::StatusOr<MPModelProto> model_or =
    glop::MpsFileToMPModelProto(mps_file);
  if (!model_or.ok()){
    LOG(WARNING) << "Unable to read " << mps_file;
    std::string exception_msg = "Unable to read " + mps_file; 
    throw std::runtime_error(exception_msg);
  }
  return model_or.value();
}

void solveGurobi(mps_file) {
  MPModelRequest::SolverType solver_type = MPModelRequest::GUROBI_LINEAR_PROGRAMMING;

  /****************/
  /* Load model */
  /****************/
  MPModelProto model_proto = loadMPSFile(mps_file);

  /****************/
  /* Set up model */
  /****************/
  MPModelRequest model_request;
  *model_request.mutable_model() = model_proto;
  model_request.set_solver_type(solver_type);
  model_request.set_enable_internal_solver_output(true);

  /****************/
  /* Set parameters */
  /****************/
  absl::StatusOr<GRBenv*>  grb_env = GetGurobiEnv();
  if (!grb_env.ok()) {
    LOG(ERROR) << grb_env.status();
    return;
  } 
  // Select solver method (Primal or barrier)
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_METHOD, GRB_METHOD_PRIMAL); 
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_METHOD, GRB_METHOD_BARRIER); 

  GRBsetintparam(grb_env.value(), GRB_INT_PAR_OUTPUTFLAG, 1);
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_THREADS, 1);
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_DISPLAYINTERVAL, 1); 

  // Presolve disabled 
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_PRESOLVE, 0);

  /* Simplex params */

  // Primal feasibility tolerance
  GRBsetdblparam(grb_env.value(), GRB_DBL_PAR_FEASIBILITYTOL, 1.0e-3); 

  /* Barrier params */

  // Crossover disabled: Crossover transforms the interior solution 
  //  produced by barrier into a basic solution
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_CROSSOVER, 0);
  // Barrier convergence tolerance: Controls accuracy of solution
  GRBsetdblparam(grb_env.value(), GRB_DBL_PAR_BARCONVTOL, 1.0e-3);

  /****************/
  /* Print params */
  /****************/
  absl::PrintF(
      "%-12s: %s\n", "Solver",
      MPModelRequest::SolverType_Name(model_request.solver_type()).c_str());
  absl::PrintF("%-12s: %d x %d\n", "Dimension",
               model_request.model().constraint_size(),
               model_request.model().variable_size());

  /****************/
  /* Solve model */
  /****************/
  absl::StatusOr<MPSolutionResponse> solution_response = GurobiSolveProto(
    model_request, grb_env.value());
  
  /* View solution */
  if (solution_response.value().status() != MPSolverResponseStatus::MPSOLVER_OPTIMAL) {
    LOG(FATAL) << "The problem does not have an optimal solution!";
  }

  LOG(INFO) << "objective = " << solution_response.value().objective_value();
  absl::PrintF("%-12s: %s\n", "Status", MPSolverResponseStatus_Name( 
    static_cast<MPSolverResponseStatus>(solution_response.value().status())).c_str());
}

}  // namespace operations_research

int main() {
  operations_research::solveGurobi("../data/ship12l.mps");
  operations_research::solveGurobi("../data/ship12s.mps");
  operations_research::solveGurobi("../data/greenbeb.mps");

  return EXIT_SUCCESS;
}