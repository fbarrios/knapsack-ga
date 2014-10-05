require './lib/knapsack_solver.rb'
require './lib/file_utils.rb'
require 'test/unit'
require 'benchmark'

class TestNAME < Test::Unit::TestCase

	DatasetDirectory = 'tests/dataset/'

	CapacityFileFormat = 'p%02d_c.txt'
	WeightsFileFormat = 'p%02d_w.txt'
	ProfitsFileFormat = 'p%02d_p.txt'
	SolutionFileFormat = 'p%02d_s.txt'

    def test_method
      1.upto(8) do |testno|
        capacity_file_name = DatasetDirectory + CapacityFileFormat % testno
        capacity = get_single_value_from_file(capacity_file_name)

        weights_file_name = DatasetDirectory + WeightsFileFormat % testno
        weights = get_integer_list_from_file(weights_file_name)

        profits_file_name = DatasetDirectory + ProfitsFileFormat % testno
        profits = get_integer_list_from_file(profits_file_name)

        puts "Solving problem ##{ testno }."

        knapsack_problem = KnapsackProblem.new(capacity, weights, profits)
        knapsack_solver = KnapsackSolver.new(knapsack_problem)

        solution = 0

        time_elapsed = Benchmark.realtime {
          solution = knapsack_solver.solve()
        }

        solution_profit = knapsack_problem.solution_profit(solution)

        solution_file_name = DatasetDirectory + SolutionFileFormat % testno
        optimal_solution = get_boolean_list_from_file(solution_file_name)
        optimal_solution_profit = knapsack_problem.solution_profit(optimal_solution)

        if optimal_solution_profit == solution_profit
          puts 'Optimal solution found!'
        else
          puts "Non optimal solution found! Expected: #{ optimal_solution_profit }, found: #{ solution_profit }."
        end

        puts "Time elapsed: #{ time_elapsed } seconds.\n\n"
      end
    end

end
