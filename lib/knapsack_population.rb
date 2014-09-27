require "item.rb"

class KnapsackPopulation

	# Initializes the first population randomly.
	def create_first
		@population = (0 .. @items.length).collect{ rand(2) == 1 ? true : false }
	end
		
		
	def initialize(items, max_capacity)
		@items, @max_capacity = items, max_capacity
		@population = []
	end
	
	
	def fitness
		return 1
	end
	
	
	def to_s
		"#@population"
	end

end
