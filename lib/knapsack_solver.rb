require "item.rb"
require "chromosome.rb"

class KnapsackSolver
	
	NumberOfGenerations = 100
	NumberOfChromosomes = 10

	@population
	
	
	def initialize(knapsack_problem)
		@knapsack_problem = knapsack_problem
		
		@population = (1 .. NumberOfChromosomes).collect{ 
			Chromosome.new(knapsack_problem)
		}
	end
	
	
	# Solves the knapsack problem using a genetic algorithm.
	def solve
		generation = 1
		
		fitness_values = @population.collect { |chromosome| chromosome.fitness }
		
		while number_of_max_fitness_values(fitness_values) < 9 \
				and generation < NumberOfGenerations
			
			if number_of_max_fitness_values(fitness_values) < 9 
				chromosome_1, chromosome_2 = select_parents
			
				new_gen = chromosome_1.crossover(chromosome_2)
				etilist_replace(new_gen)
				
				@population.sample.mutate
			end
		
			fitness_values = @population.collect { |chromosome| chromosome.fitness }
			generation += 1
		end
		
		@population.sort! { |c1, c2| c1.fitness <=> c2.fitness }
		return @population.pop.chromosome
	end
	
	
	private
	
	
	# Selects two chromosomes as parents for the next generation.
	def select_parents
		ordered_chromosomes = @population.sort { |c1, c2| c2.fitness <=> c1.fitness }

		parents = []
	
		2.times {
			population_size = ordered_chromosomes.size
		
			# Divides the population into four groups according to their
			# fitness and assigns a probability of selection to each.
			random_number = rand(99)
			
			if random_number < 50
				bottom = 0
				top = population_size / 4 - 1
			elsif 50 <= random_number and random_number < 80
				bottom = population_size / 4
				top = population_size / 2 - 1
			elsif 80 <= random_number and random_number < 95
				bottom = population_size / 2
				top = population_size * 3 / 4 - 1
			elsif 95 <= random_number
				bottom = population_size * 3 / 4
				top = population_size - 1
			end
			
			selected_index = bottom + rand(top - bottom + 1)
			
			parents.push ordered_chromosomes.at(selected_index)
			ordered_chromosomes.delete_at(selected_index)
		}
		
		return parents[0], parents[1]
	end
	
	
	# Replaces two chromosomes for the next generation.
	def etilist_replace(new_gen)
		ordered_chromosomes = @population.sort { |c1, c2| c1.fitness <=> c2.fitness }
				
		@population.shift
		
		@population.push new_gen
	end
	
	# Returns the number of chromosomes in the population which have the
	# maximum fitness value.
	def number_of_max_fitness_values(fitness_values)
		return fitness_values.count(fitness_values.max)
	end
end
