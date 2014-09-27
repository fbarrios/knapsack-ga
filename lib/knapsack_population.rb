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
	
	
	def selected_items
		selected = []
		
		for i in 0 ... @items.size
			if population.at(i)
				selected.push @items.at(i)
			end
		end
		
		return selected
	end
	
	
	def total_weight
		return selected_items.reduce(0) { |total, item| total += item.weight }
	end
	
	
	def total_profit
		return selected_items.reduce(0) { |total, item| total += item.profit }
	end
	
	
	def fitness		
		puts population
		puts total_weight
	end
	
	
	def to_s
		"#@population"
	end

end
