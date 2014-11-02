require 'item.rb'

class BruteForceSolver
    
  def initialize(knapsack_problem)
    @knapsack_problem = knapsack_problem
  end
  
  
  # Solves the knapsack problem using brute force.
  def solve
    problem_size = @knapsack_problem.items.size()
    max_capacity = @knapsack_problem.max_capacity
    total_profit = 0

    solutions = []
    
    # We iterate through the whole domain of posible solutions
    # the solution is an array of bits, whose integer representation is 'j'
    0.upto(2 ** problem_size) { |j|
      # For each solution, we calculate the total profit, and if it fits in the knapsack
      current_solution = selected_items(problem_size, j)
      current_weight = 0
      current_profit = 0

      0.upto(problem_size - 1) { |i|
        current_weight += current_solution[i] * @knapsack_problem.items[i].weight
        current_profit += current_solution[i] * @knapsack_problem.items[i].profit
      }

      if current_weight > max_capacity
        next
      end

      # The solution fits in the knapsack
      if current_profit > total_profit
        # The solution is greater than all the previous ones
        total_profit = current_profit
        solutions.clear()
        solutions.push(current_solution)
      elsif current_profit == total_profit
        # We found another solution to the problem
        solutions.push(current_solution)
      end
    }

    puts "\t Solutions found: #{ solutions.size } - Profit: #{ total_profit }"
    
    solutions.each { |x| puts "\t\t #{ x }" }

    return solutions
  end


  private

  # Returns an array of bits of size s wich represents number n
  def selected_items(s, n)
    return Array.new(s) { |i| n[i] }.reverse!
  end


end
