require 'item.rb'
require 'chromosome.rb'

class KnapsackSolver
	
	NumberOfGenerations = 100
	PopulationSize = 100

	@population
	
	
	def initialize(knapsack_problem)
		@knapsack_problem = knapsack_problem
		
		@population = (1 .. PopulationSize).collect{ 
			Chromosome.new(knapsack_problem)
		}
	end
	
	
	# Solves the knapsack problem using a genetic algorithm.
	def solve
		generation = 1
		
		fitness_values = @population.collect { |chromosome| chromosome.fitness }
		
		while number_of_max_fitness_values(fitness_values) < PopulationSize * 9 / 10 \
				and generation < NumberOfGenerations
			
			puts "\t Generation number: #{ generation } - Profit: #{ fitness_values.max }"

      @population.sort! { |c1, c2| c1.fitness <=> c2.fitness }
			@population = get_new_population()
		
			fitness_values = @population.collect { |chromosome| chromosome.fitness }
			generation += 1
		end
		
		puts "\t Solution found in #{generation} generations.\n"
		
		return @population.pop.chromosome
	end
	
	
	private

  def get_new_population
    new_population = []

    while new_population.size < @population.size
      offspring_1 = select
      offspring_2 = select

      new_gen = offspring_1.crossover(offspring_2)
      new_gen.mutate

      new_population.push(new_gen)
    end

    return new_population
  end
	
	
	# Selects a chromosome as offspring for the next generation.
	def select
		temp_population = @population.clone
		population_size = temp_population.size

		# Divides the population into four groups according to their
		# fitness and assigns a probability of selection to each.
		random_number = rand(99)
		
		if random_number < 5
			bottom = 0
			top = population_size / 4 - 1
		elsif 5 <= random_number and random_number < 20
			bottom = population_size / 4
			top = population_size / 2 - 1
		elsif 20 <= random_number and random_number < 50
			bottom = population_size / 2
			top = population_size * 3 / 4 - 1
		elsif 50 <= random_number
			bottom = population_size * 3 / 4
			top = population_size - 1
		end

		selected_index = bottom + rand(top - bottom + 1)
		
		return temp_population.at(selected_index)
	end
	
	# Returns the number of chromosomes in the population which have the
	# maximum fitness value.
	def number_of_max_fitness_values(fitness_values)
		return fitness_values.count(fitness_values.max) 
	end
end
