require "item.rb"

class KnapsackPopulation

	attr_reader :population

	# Initializes the first population randomly.
	def create_first
		@population = (0 .. @items.length - 1).collect{ rand(2) == 1 ? true : false }
	end
		
		
	def initialize(items, max_capacity)
		@items, @max_capacity = items, max_capacity
		population = (0 .. @items.length - 1).collect{ false }
	end
	
	
	# Returns a list of the selected items of the solution according to
	# the population list.
	def selected_items
		selected = []
		
		for i in 0 ... @items.length
			if population.at(i)
				selected.push @items.at(i)
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
	
	
	# Removes a random item from the population.
	def remove_included_item
		selected_indexes = []
		
		for i in 0 ... population.length
			if population.at(i)
				selected_indexes.push i
			end
		end
				
		population[selected_indexes.sample] = false
	end
	
	
	def fitness		
		while total_weight > @max_capacity
			remove_included_item
		end
				
		return total_weight, total_profit
	end
	
	
	def to_s
		"#@population"
	end

end
