
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
