require "./lib/NAME.rb"
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
			f.each_line { |line| content.push line.to_i } 
		end
				
		return content
    end

    def test_method
		1.upto(8) do |testno|
			capacities = parse_file_content(DatasetDirectory + CapacityFileFormat % testno)
			weights = parse_file_content(DatasetDirectory + WeightsFileFormat % testno)
			profits = parse_file_content(DatasetDirectory + ProfitsFileFormat % testno)
			solution = parse_file_content(DatasetDirectory + SolutionFileFormat % testno)
			
		end
    end

end
