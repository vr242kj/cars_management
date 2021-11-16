require_relative 'lib/read_db'
require_relative 'lib/rules'
require_relative 'lib/result_printer'

db_reader = DbReader.new

file_name = "#{File.dirname(__FILE__ )}/db/cars.yml"

cars = db_reader.read_file(file_name)

search_by_rules = Rules.new
printer = ResultPrinter.new

puts 'Please select search rules.'

unless search_by_rules.finished?
  search_by_rules.ask_rules
end

printer.print_result(search_by_rules)
