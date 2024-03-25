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

void solveGLOP() {
  std::string mps_file = "../data/s250r10.mps";
  // std::string mps_file = "../data/23588.mps";

  // Solvers available: /home/john/apps/or-tools/ortools/linear_solver/linear_solver.proto
  MPModelRequest::SolverType solver_type = MPModelRequest::GLOP_LINEAR_PROGRAMMING;
  // MPModelRequest::SolverType solver_type = MPModelRequest::CLP_LINEAR_PROGRAMMING;

  /****************/
  /* Load model */
  /****************/
  MPModelProto model_proto = loadMPSFile(mps_file);

  /****************/
  /* Set up model */
  /****************/
  // /usr/local/include/ortools/linear_solver/linear_solver.pb.h

  MPModelRequest model_request;
  *model_request.mutable_model() = model_proto;
  model_request.set_solver_type(solver_type);
  model_request.set_enable_internal_solver_output(true);

  // GLOP parameters: /home/john/apps/or-tools/ortools/glop/parameters.proto
  model_request.set_solver_specific_parameters(
    "primal_feasibility_tolerance: 1e-9, \\
    log_to_stdout: true, \\
    log_search_progress: true");
  std::cout << "solver_specific_parameters: " << model_request.solver_specific_parameters() << std::endl;

  absl::PrintF(
      "%-12s: %s\n", "Solver",
      MPModelRequest::SolverType_Name(model_request.solver_type()).c_str());
  // absl::PrintF("%-12s: %s\n", "Parameters", absl::GetFlag(FLAGS_params));
  absl::PrintF("%-12s: %d x %d\n", "Dimension",
               model_request.model().constraint_size(),
               model_request.model().variable_size());

  const absl::Time solve_start_time = absl::Now();

  /****************/
  /* Solve model */
  /****************/
  MPSolutionResponse solution_response;
  MPSolver::SolveWithProto(model_request, &solution_response);
  
  /* View solution */
  if (solution_response.status() != MPSolverResponseStatus::MPSOLVER_OPTIMAL) {
    LOG(FATAL) << "The problem does not have an optimal solution!";
  }

  LOG(INFO) << "objective = " << solution_response.objective_value();

  const absl::Duration solving_time = absl::Now() - solve_start_time;
  absl::PrintF("%-12s: %s\n", "Status",
               MPSolverResponseStatus_Name(
                   static_cast<MPSolverResponseStatus>(solution_response.status()))
                   .c_str());

  const bool has_solution = solution_response.status() == MPSOLVER_OPTIMAL ||
                            solution_response.status() == MPSOLVER_FEASIBLE;
  if (has_solution){
    absl::PrintF("%-12s: %15.15e\n", "Objective",
                has_solution ? solution_response.objective_value() : 0.0);
    absl::PrintF("%-12s: %15.15e\n", "BestBound",
                has_solution ? solution_response.best_objective_bound() : 0.0);

    absl::PrintF("%-12s: %-6.4g s\n", "Wall Time", solution_response.solve_info().solve_wall_time_seconds());
    absl::PrintF("%-12s: %-6.4g s\n", "User Time", solution_response.solve_info().solve_user_time_seconds());
    
    // if (solution_response.dual_value())
    // absl::PrintF("%-12s: %-6.4g\n", "dual_value: ", solution_response.dual_value());
  }

  absl::PrintF("%-12s: %s\n", "StatusString", solution_response.status_str());
  absl::PrintF("%-12s: %-6.4g s\n", "Time", absl::ToDoubleSeconds(solving_time));
  
}

void solveGurobi() {
  // Small test problems
  // std::string mps_file = "../data/ship12l.mps";
  // std::string mps_file = "../data/ship12s.mps";
  std::string mps_file = "../data/greenbeb.mps";

  // std::string mps_file = "../data/ex10.mps";
  // std::string mps_file = "../data/s250r10.mps";
  // std::string mps_file = "../data/23588.mps";

  // Solvers available: /home/john/apps/or-tools/ortools/linear_solver/linear_solver.proto
  MPModelRequest::SolverType solver_type = MPModelRequest::GUROBI_LINEAR_PROGRAMMING;

  /****************/
  /* Load model */
  /****************/
  MPModelProto model_proto = loadMPSFile(mps_file);

  /****************/
  /* Set up model */
  /****************/
  // /usr/local/include/ortools/linear_solver/linear_solver.pb.h
  MPModelRequest model_request;
  *model_request.mutable_model() = model_proto;
  model_request.set_solver_type(solver_type);
  model_request.set_enable_internal_solver_output(true);

  /****************/
  /* Set parameters */
  /****************/

  // https://www.gurobi.com/documentation/current/refman/environments.html#sec:Environment
  // At the highest level, environments provide three basic functions: (i) to capture a set of parameter settings, (ii) to delineate a (single-threaded) Gurobi session, and (iii) to hold a Gurobi license
  absl::StatusOr<GRBenv*>  grb_env = GetGurobiEnv();
  if (!grb_env.ok()) {
    LOG(ERROR) << grb_env.status();
    return;
  } 
  // Select method
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_METHOD, GRB_METHOD_PRIMAL); // GRB_METHOD_PRIMAL, GRB_METHOD_BARRIER, GRB_METHOD_DETERMINISTIC_CONCURRENT
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_METHOD, GRB_METHOD_BARRIER); // GRB_METHOD_PRIMAL, GRB_METHOD_BARRIER, GRB_METHOD_DETERMINISTIC_CONCURRENT

  GRBsetintparam(grb_env.value(), GRB_INT_PAR_OUTPUTFLAG, 1);
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_THREADS, 1);
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_DISPLAYINTERVAL, 1); // Determines the frequency at which log lines are printed
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_NUMERICFOCUS, 0); // controls the degree to which the code attempts to detect and manage numerical issues. The default setting (0) makes an automatic choice, with a slight preference for speed. 
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_SOLUTIONTARGET, -1); // Specifies the solution target for linear programs (LP). Options are Automatic (-1), primal and dual optimal, and basic (0), primal and dual optimal (1).

  // Turn off model scaling. "By default, the rows and columns of the model are scaled in order to improve the numerical properties of the constraint matrix."
  // "Scaling typically reduces solution times, but it may lead to larger constraint violations in the original, unscaled model"
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_SCALEFLAG, 0); //https://www.gurobi.com/documentation/current/refman/scaleflag.html#parameter:ScaleFlag
  // Objective scaling set to identity, "When positive, divides the model objective by the specified value to avoid numerical issues that may result from very large or very small objective coefficients"
  // GRBsetdblparam(grb_env.value(), GRB_DBL_PAR_OBJSCALE, 1.0); //https://www.gurobi.com/documentation/current/refman/objscale.html#parameter:ObjScale
  // Presolve set to automatic 
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_PRESOLVE, 0);

  /* Simplex params */
  // Disable use of network simplex
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_NETWORKALG, 0); //https://www.gurobi.com/documentation/current/refman/networkalg.html#parameter:NetworkAlg
  // Choose simplex strategy: We chooose STEEPEST EDGE. "Changing the value of this parameter rarely produces a significant benefit"
  // GRBsetintparam(grb_env.value(), GRB_INT_PAR_SIMPLEXPRICING, GRB_SIMPLEXPRICING_STEEPEST_EDGE); //https://www.gurobi.com/documentation/current/refman/normadjust.html#parameter:NormAdjust

  // Primal feasibility tolerance
  GRBsetdblparam(grb_env.value(), GRB_DBL_PAR_FEASIBILITYTOL, 1.0e-3); // Range: (1e-9, 1e-6, 1e-2) https://www.gurobi.com/documentation/current/refman/feasibilitytol.html#parameter:FeasibilityTol

  /* Barrier params */

  // Limits number of central corrections performed in each barrier iteration, selected automatically.
  // More corrections generally lead to more forward progress in each iteration, but at a cost of more expensive iterations. 
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_BARCORRECTORS, -1); //https://www.gurobi.com/documentation/current/refman/barcorrectors.html#parameter:BarCorrectors
  // Crossover disabled: Crossover transforms the interior solution produced by barrier into a basic solution
  GRBsetintparam(grb_env.value(), GRB_INT_PAR_CROSSOVER, 0); //https://www.gurobi.com/documentation/current/refman/crossover.html#parameter:Crossover

  // Barrier convergence tolerance: Controls accuracy of solution
  GRBsetdblparam(grb_env.value(), GRB_DBL_PAR_BARCONVTOL, 1.0e-12); //https://www.gurobi.com/documentation/current/refman/barconvtol.html#parameter:BarConvTol

  /****************/
  /* Print params */
  /****************/
  absl::PrintF(
      "%-12s: %s\n", "Solver",
      MPModelRequest::SolverType_Name(model_request.solver_type()).c_str());
  // absl::PrintF("%-12s: %s\n", "Parameters", absl::GetFlag(FLAGS_params));
  absl::PrintF("%-12s: %d x %d\n", "Dimension",
               model_request.model().constraint_size(),
               model_request.model().variable_size());

  /****************/
  /* Solve model */
  /****************/
  absl::StatusOr<MPSolutionResponse> solution_response = GurobiSolveProto(model_request, grb_env.value());
  
  /* View solution */
  if (solution_response.value().status() != MPSolverResponseStatus::MPSOLVER_OPTIMAL) {
    LOG(FATAL) << "The problem does not have an optimal solution!";
  }

  LOG(INFO) << "objective = " << solution_response.value().objective_value();

  absl::PrintF("%-12s: %s\n", "Status",
               MPSolverResponseStatus_Name(
                   static_cast<MPSolverResponseStatus>(solution_response.value().status()))
                   .c_str());

  const bool has_solution = solution_response.value().status() == MPSOLVER_OPTIMAL ||
                            solution_response.value().status() == MPSOLVER_FEASIBLE;
  if (has_solution){
    absl::PrintF("%-12s: %15.15e\n", "Objective",
                has_solution ? solution_response.value().objective_value() : 0.0);
    absl::PrintF("%-12s: %15.15e\n", "BestBound",
                has_solution ? solution_response.value().best_objective_bound() : 0.0);

    absl::PrintF("%-12s: %-6.4g s\n", "Wall Time", solution_response.value().solve_info().solve_wall_time_seconds());
    absl::PrintF("%-12s: %-6.4g s\n", "User Time", solution_response.value().solve_info().solve_user_time_seconds());
    
    // if (solution_response.dual_value())
    // absl::PrintF("%-12s: %-6.4g\n", "dual_value: ", solution_response.dual_value());
  }

  absl::PrintF("%-12s: %s\n", "StatusString", solution_response.value().status_str());
  
}

}  // namespace operations_research

int main() {
  // operations_research::solveGLOP();
  operations_research::solveGurobi();
  return EXIT_SUCCESS;
}