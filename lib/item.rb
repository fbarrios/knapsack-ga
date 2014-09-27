
class Item
	attr_reader :weight
	attr_reader :profit
	
	def initialize(weight, profit)
		@weight, @profit = weight, profit	
	end

	def to_s
		"Item of width #@weight and profit #@profit"
	end

end
