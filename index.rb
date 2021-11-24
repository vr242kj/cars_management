require_relative 'lib/read_db'
require_relative 'lib/write_db'
require_relative 'lib/rules'
require_relative 'lib/result_printer'

db_reader = DbReader.new
db_writer = DbWriter.new

file_name = "#{File.dirname(__FILE__)}/db/cars.yml"

cars = db_reader.read_file(file_name)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

file_write_name = "#{File.dirname(__FILE__)}/db/searches.yml"

searches = db_reader.read_file(file_write_name)

searches.push(search_by_rules.user_answers)

db_writer.write_file(searches)

match_cars = search_by_rules.match_cars

puts 'Please choose sort option (date_added|price):'
puts 'Press d if date_added or press p if price'

sort_option = search_by_rules.sort_option(match_cars)

puts 'Please choose sort direction(desc|asc):'
puts 'Press d if desc or press a if asc'

sort_direction = search_by_rules.sort_direction(sort_option)

file_write_name = "#{File.dirname(__FILE__)}/db/searches.yml"

searches = db_reader.read_file(file_write_name)

req_quantity = search_by_rules.requests_quantity(searches)

printer.print_statics(sort_direction.length, req_quantity)

printer.print_result(sort_direction)
