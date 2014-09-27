require "item.rb"
require "knapsack_population.rb"

class KnapsackSolver
	attr_reader :items
	attr_reader :max_capacity
	
	# Creates a knapsack given the maximum capacity, a list of item 
	# weights and a list of item profits.
	def initialize(max_capacity, weights, profits)
		
		@max_capacity = max_capacity
		@items = []
		
		for i in 0 ... weights.size
			items.push Item.new(weights.at(i), profits.at(i))
		end	
		
	end
	
	
	# Solves the knapsack problem using a genetic algorithm.
	def solve
		
		population = KnapsackPopulation.new(items, max_capacity)
		population.create_first
		population.fitness
		
	end
	
	
	def to_s
		"Knapsack problem of maximum capacity #@max_capacity with items #@items"
	end


end
