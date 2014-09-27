require "item.rb"

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

	
	def to_s
		"Knapsack problem of maximum capacity #@max_capacity with items #@items"
	end

end
