require "item.rb"
require "knapsack_chromosome.rb"

class KnapsackSolver
	
	NumberOfGenerations = 100
	NumberOfChromosomes = 10

	@generation
	@population
	
	def initialize(knapsack_problem)
		@knapsack_problem = knapsack_problem
		
		@population = (1 .. NumberOfChromosomes).collect{ 
			KnapsackChromosome.new(knapsack_problem)
		}
	end
	
	
	# Solves the knapsack problem using a genetic algorithm.
	def solve
		puts @population
	end
	
end
