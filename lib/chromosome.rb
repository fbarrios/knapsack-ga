require 'knapsack_problem.rb'

class Chromosome

	attr_reader :chromosome
  @_fitness

	def initialize(knapsack_problem, chromosome=nil)
		@knapsack_problem = knapsack_problem
		
		if chromosome == nil
			# Initializes the chromosome randomly.
			@chromosome = (0 .. knapsack_problem.items.size - 1).collect { 
				rand(2) == 1 ? true : false 
			}
		else
			@chromosome = chromosome
    end

    validate()
	end


	def fitness
    if @_fitness.nil?
      @_fitness = selected_items.reduce(0) { |total, item| total += item.profit }
    end

    return @_fitness
	end
	
	
	def crossover(other)
		ratio = rand(self.chromosome.size)
		new_gen_data = self.chromosome[0, ratio] + other.chromosome[ratio, self.chromosome.size]
		
		return Chromosome.new(@knapsack_problem, new_gen_data)
	end
	
	
	def mutate
		for i in 0 ... chromosome.size - 1
			random_number = rand(1000)
			
			if random_number == 0
				chromosome[i] = !chromosome[i]
			end
    end

    validate()
	end	
	
	
	def to_s
		"Chromosome with solution: #{chromosome.collect{ |c| c == true ? 1 : 0 }}\n"
	end


	private

  # Verifies that the total weight of the solution doesn't exceed the
  # maximum knapsack capacity and removes random items if it does.
  def validate
    while total_weight > @knapsack_problem.max_capacity
      remove_included_item
    end
  end

	
	def selected_items
		return @knapsack_problem.selected_items(chromosome)
	end


	# Returns the total weight of the selected items.
	def total_weight
		return selected_items.reduce(0) { |total, item| total += item.weight }
	end
	

	# Removes a random item from the chromosome.
	def remove_included_item
		selected_indexes = []

		for i in 0 ... chromosome.size
			if chromosome.at(i) == true
				selected_indexes.push i
			end
		end
				
		chromosome[selected_indexes.sample] = false
  end

end
