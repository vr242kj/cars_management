require_relative 'lib/read_db'
require_relative 'lib/write_db'
require_relative 'lib/rules'
require_relative 'lib/result_printer'
require_relative 'lib/statistic'

db_reader = DbReader.new
db_writer = DbWriter.new

File.new('db/cars.yml', 'a+')

file_name = "#{File.dirname(__FILE__)}/db/cars.yml"

cars = db_reader.read_file(file_name)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

File.new('db/searches.yml', 'a+')

file_write_name = "#{File.dirname(__FILE__)}/db/searches.yml"

searches = db_reader.read_file(file_write_name)

searches ||= []

match_cars = search_by_rules.match_cars

puts 'Please choose sort option (date_added|price):'
puts 'Press d if date_added or press p if price'

sort_option = search_by_rules.sort_option(match_cars)

puts 'Please choose sort direction(desc|asc):'
puts 'Press d if desc or press a if asc'

sort_direction = search_by_rules.sort_direction(sort_option)

statistic = Statistic.new

req_quantity = statistic.requests_quantity(searches, search_by_rules.user_answers)
total_quantity = statistic.total_quantity(sort_direction)

searches.push(search_by_rules.user_answers)
searches.push('total_quantity' => total_quantity)
searches.push('requests_quantity' => req_quantity)

db_writer.write_file(searches)

printer.print_statics(total_quantity, req_quantity)

printer.print_result(sort_direction)
