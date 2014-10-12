require 'item.rb'

class BruteForceSolver
    
  def initialize(knapsack_problem)
    @knapsack_problem = knapsack_problem
  end
  
  
  # Solves the knapsack problem using brute force.
  def solve
    problemSize = @knapsack_problem.items.size();
    maxCapacity = @knapsack_problem.max_capacity;
    totalProfit = 0;

    solutions = []
    
    # We iterate through the hole domain of posibles solutions
    # the solution is an array of bits, whose integer representation is 'j'
    for j in 0..2**problemSize
      # For each solution, we calculate the total profit, and if it fits in the knapsack 
      currentSolution = selected_items(problemSize, j);        
      currentWeight = 0;
      currentProfit = 0;
	    for i in 0..(problemSize-1)
        currentWeight += currentSolution[i] * @knapsack_problem.items[i].weight;
        currentProfit += currentSolution[i] * @knapsack_problem.items[i].profit;
      end

      if (currentWeight <= maxCapacity) 
        # The solution fits in the knapsack
        if (currentProfit > totalProfit)
          # The solution is greater than all the previous ones
          totalProfit = currentProfit;
          solutions.clear();
          solutions.push(currentSolution);
        elsif (currentProfit == totalProfit)
          # We found another solution to the problem
          solutions.push(currentSolution);
        end

      end
    end
    puts "\t Solutions found: #{ solutions.size } - Profit: #{ totalProfit }"
    
    solutions.each { |x| puts "\t\t #{ x }" }    
      

    return solutions;
  end


  private

  # Returns an array of bits of size s wich represents number n
  def selected_items(s, n)
    return Array.new(s) { |i| n[i] }.reverse!
  end


end
