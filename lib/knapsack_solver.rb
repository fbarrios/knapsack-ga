require "item.rb"
require "knapsack_chromosome.rb"

class KnapsackSolver
	
	NumberOfGenerations = 100
	NumberOfChromosomes = 10

	@population
	
	
	def initialize(knapsack_problem)
		@knapsack_problem = knapsack_problem
		
		@population = (1 .. NumberOfChromosomes).collect{ 
			KnapsackChromosome.new(knapsack_problem)
		}
	end
	
	
	# Solves the knapsack problem using a genetic algorithm.
	def solve
		generation = 1
		
		fitness_values = @population.collect { |chromosome| chromosome.fitness }
		
		while number_of_max_fitness_values(fitness_values) < 9 \
				and generation < NumberOfGenerations
			
			if number_of_max_fitness_values(fitness_values) < 9 
				chromosome_1 = @population.sample
				chromosome_2 = @population.sample
			
				chromosome_1.crossover(chromosome_2)
				chromosome_1.mutate(chromosome_2)
			end
		
			fitness_values = @population.collect { |chromosome| chromosome.fitness }
			generation += 1
		end
		
		return @population.sample
	end
	
	
	# Returns the number of chromosomes in the population which have the
	# maximum fitness value.
	def number_of_max_fitness_values(fitness_values)
		return fitness_values.count(fitness_values.max)
	end
end
