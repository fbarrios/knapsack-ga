require "knapsack_problem.rb"

class Chromosome

	attr_reader :chromosome

	def initialize(knapsack_problem, chromosome=chromosome)
		@knapsack_problem = knapsack_problem
		
		if chromosome.nil?
			# Initializes the chromosome randomly.
			@chromosome = (0 .. knapsack_problem.items.size - 1).collect { 
				rand(2) == 1 ? true : false 
			}
		else
			@chromosome = chromosome
		end
	end


	def fitness
		while total_weight > @knapsack_problem.max_capacity
			remove_included_item
		end
				
		return total_weight
	end
	
	
	def crossover(other)
		items_size = self.chromosome.size
		new_gen = self.chromosome[0, items_size / 2] + other.chromosome[items_size / 2, items_size]
	
		return Chromosome.new(@knapsack_problem, chromosome=new_gen)
	end
	
	
	def mutate
		for i in 0 ... chromosome.size - 1
			random_number = rand(1000)
			
			if random_number == 0
				chromosome[i] = !chromosome[i]
			end
		end
	end	
	
	
	def to_s
		"Selected indexes in the chromosome: #{selected_items}"
	end


	private
	
	
	def selected_items
		return @knapsack_problem.selected_items(chromosome)
	end
	
	# Returns the total weight of the selected items.
	def total_weight
		return selected_items.reduce(0) { |total, item| total += item.weight }
	end
	
	
	# Returns the total profits of the selected items.
	def total_profit
		return selected_items.reduce(0) { |total, item| total += item.profit }
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
