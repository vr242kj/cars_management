require_relative 'lib/read_db'
require_relative 'lib/rules'
require_relative 'lib/result_printer'

db_reader = DbReader.new

file_name = "#{File.dirname(__FILE__)}/db/cars.yml"

cars = db_reader.read_file(file_name)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

sort_option = search_by_rules.sort_option(match_cars)

sort_direction = search_by_rules.sort_direction(sort_option)

printer.print_result(sort_direction)
