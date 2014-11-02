require './lib/brute_force_solver.rb'
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

  def test_ga_solver

    puts '*** Genetic Algorithm ***'

    tests_ok = 0
    tests_failed = 0

    1.upto(8) { |testno|
      capacity_file_name = DatasetDirectory + CapacityFileFormat % testno
      capacity = get_single_value_from_file(capacity_file_name)

      weights_file_name = DatasetDirectory + WeightsFileFormat % testno
      weights = get_integer_list_from_file(weights_file_name)

      profits_file_name = DatasetDirectory + ProfitsFileFormat % testno
      profits = get_integer_list_from_file(profits_file_name)

      puts "Solving problem ##{ testno } using a Genetic Algorithm."

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
        puts 'GA Optimal solution found!'
        tests_ok += 1
      else
        puts "GA Non optimal solution found! Expected: #{ optimal_solution_profit }, found: #{ solution_profit }."
        tests_failed += 1
      end

      puts "GA Time elapsed: #{ time_elapsed } seconds for #{ weights.size } items.\n\n"

    }

    puts "GA Optimal solutions found: #{ tests_ok }"
    puts "GA Non optimal solutions found: #{ tests_failed }"
  end




  def test_bf_solver

    puts '*** Brute Force ***'

    tests_ok = 0
    tests_failed = 0

    1.upto(8) { |testno|
      capacity_file_name = DatasetDirectory + CapacityFileFormat % testno
      capacity = get_single_value_from_file(capacity_file_name)

      weights_file_name = DatasetDirectory + WeightsFileFormat % testno
      weights = get_integer_list_from_file(weights_file_name)

      profits_file_name = DatasetDirectory + ProfitsFileFormat % testno
      profits = get_integer_list_from_file(profits_file_name)

      puts "Solving problem ##{ testno } using Brute Force."

      knapsack_problem = KnapsackProblem.new(capacity, weights, profits)
      bruteForce_solver = BruteForceSolver.new(knapsack_problem)

      solution = 0

      time_elapsed = Benchmark.realtime {
        solution = bruteForce_solver.solve()
      }

      # The brute force method, will give us all the solutions, we just want one
      solution_profit = knapsack_problem.solution_profit(solution[0])

      solution_file_name = DatasetDirectory + SolutionFileFormat % testno
      optimal_solution = get_boolean_list_from_file(solution_file_name)
      optimal_solution_profit = knapsack_problem.solution_profit(optimal_solution)

      if optimal_solution_profit == solution_profit
        puts 'BF Optimal solution found!'
        tests_ok += 1
      else
        puts "BF Non optimal solution found! Expected: #{ optimal_solution_profit }, found: #{ solution_profit }."
        tests_failed += 1
      end

      puts "BF Time elapsed: #{ time_elapsed } seconds for #{ weights.size } items.\n\n"

    }

    puts "BF Optimal solutions found: #{ tests_ok }"
    puts "BF Non optimal solutions found: #{ tests_failed }"
  end

end
