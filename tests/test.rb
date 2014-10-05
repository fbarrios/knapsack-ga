require './lib/knapsack_solver.rb'
require './lib/file_utils.rb'
require 'test/unit'

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
        solution = knapsack_solver.solve()

        solution_file_name = DatasetDirectory + SolutionFileFormat % testno
        optimal_solution = get_boolean_list_from_file(solution_file_name)

        assert_equal knapsack_problem.solution_profit(optimal_solution),
               knapsack_problem.solution_profit(solution)
      end
    end

end
