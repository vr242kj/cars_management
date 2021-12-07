# frozen_string_literal: true
require_relative 'lib/database'
require_relative 'lib/rules'
require_relative 'lib/result_printer'
require_relative 'lib/statistics'

database = Database.new

file_cars = 'cars'
file_searches = 'searches'

cars = database.read(file_cars)

read_searches = database.read(file_searches, true)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

statistics = Statistics.new(match_cars)

requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
total_statistic = statistics.total_statistic(requests_values, read_searches)
database.write(file_searches, total_statistic)

puts 'Please choose sort option (date_added|price):'
puts 'Press d if date_added or press p if price'
sort_option = search_by_rules.sort_option(match_cars)

puts 'Please choose sort direction (desc|asc):'
puts 'Press d if desc or press a if asc'
sort_direction = search_by_rules.sort_direction(sort_option)

print_total_statistics = statistics.find_statistic(requests_values)

printer.print_statics(print_total_statistics)

printer.print_result(sort_direction)