require 'item.rb'

class KnapsackProblem

	attr_reader :items
	attr_reader :max_capacity

	# Creates a knapsack problem given the maximum capacity, a list of 
	# item weights and a list of item profits.
	def initialize(max_capacity, weights, profits)
	
		@items = []
	
		for i in 0 ... weights.size
			@items.push Item.new(weights.at(i), profits.at(i))
		end	
	
		@max_capacity = max_capacity
	end


	# Returns the profit of a given solution.
	def solution_profit(solution)
		selected_items(solution).reduce(0) { |total, item| total += item.profit }
	end


	# Returns a list of the selected items given a solution.
	def selected_items(solution)
		selected = []
		
		for i in 0 ... items.size
			if solution.at(i) == true
				selected.push items.at(i)
			end
		end
		
		return selected
	end
	
end
