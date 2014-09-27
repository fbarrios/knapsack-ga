require "knapsack_problem.rb"

class Chromosome

	attr_reader :chromosome

	def initialize(knapsack_problem)
		@knapsack_problem = knapsack_problem
				
		# Initializes the chromosome randomly.
		@chromosome = (0 .. knapsack_problem.items.size - 1).collect { 
			rand(2) == 1 ? true : false 
		}
	end


	def fitness
		while total_weight > @knapsack_problem.max_capacity
			remove_included_item
		end
				
		return total_weight
	end
	
	
	def crossover(other)
		return nil
	end
	
	
	def mutate(other)
		return nil
	end	
	
	
	def to_s
		"Selected indexes in the chromosome: #{selected_items}"
	end


	private
	
	# Returns a list of the selected items of the solution according to
	# the chromosome list.
	def selected_items
		selected = []
		
		for i in 0 ... @knapsack_problem.items.size
			if chromosome.at(i) == true
				selected.push @knapsack_problem.items.at(i)
			end
		end
		
		return selected
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
