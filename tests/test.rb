require "./lib/knapsack_solver.rb"
require "test/unit"

class TestNAME < Test::Unit::TestCase

	DatasetDirectory = "tests/dataset/"

	CapacityFileFormat = "p%02d_c.txt"
	WeightsFileFormat = "p%02d_w.txt"
	ProfitsFileFormat = "p%02d_p.txt"
	SolutionFileFormat = "p%02d_s.txt"


    def parse_file_content(file_name)
		content = []
		
		File.open file_name do |f|
			f.each_line { |line| content.push line } 
		end
				
		return content
    end
    
    
    def get_single_value_from_file(file_name)
		parse_file_content(file_name).first.to_i
    end

	
	def get_integer_list_from_file(file_name)
		content = parse_file_content(file_name)
		content.map! { |c| c.to_i }
	end
	
	
	def get_boolean_list_from_file(file_name)
		content = parse_file_content(file_name)
		content.map! { |c| c.to_i == 1 ? true : false }
	end


    def test_method
		1.upto(1) do |testno|
			capacity_file_name = DatasetDirectory + CapacityFileFormat % testno
			capacity = get_single_value_from_file(capacity_file_name)
			
			weights_file_name = DatasetDirectory + WeightsFileFormat % testno
			weights = get_integer_list_from_file(weights_file_name)
			
			profits_file_name = DatasetDirectory + ProfitsFileFormat % testno
			profits = get_integer_list_from_file(profits_file_name)
			
			knapsack_problem = KnapsackProblem.new(capacity, weights, profits)
			knapsack_solver = KnapsackSolver.new(knapsack_problem)
			knapsack_solver.solve
			
			solution_file_name = DatasetDirectory + SolutionFileFormat % testno
			solution = get_boolean_list_from_file(solution_file_name)
		end
    end

end
