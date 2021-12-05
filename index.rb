# frozen_string_literal: true
require_relative 'lib/database'
require_relative 'lib/rules'
require_relative 'lib/result_printer'
require_relative 'lib/statistics'

file_name = "/db/cars.yml"
file_searches = "/db/searches.yml"

cars = Database.new(file_name)
cars = cars.read

searches = Database.new(file_searches)
searches = searches.read

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new
statistics = Statistics.new

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

statistics.make_total_quantity(match_cars)
requests_quantity = statistics.valuable_request_values(search_by_rules.user_answers)
total_statistic = statistics.total_statistic(requests_quantity, searches)
searches.write(total_statistic)

puts 'Please choose sort option (date_added|price):'
puts 'Press d if date_added or press p if price'
sort_option = search_by_rules.sort_option(match_cars)

puts 'Please choose sort direction(desc|asc):'
puts 'Press d if desc or press a if asc'
sort_direction = search_by_rules.sort_direction(sort_option)

print_total_statistics = statistics.print_total_statistics(requests_quantity)

printer.print_statics(print_total_statistics)

printer.print_result(sort_direction)
