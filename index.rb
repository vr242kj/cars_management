# frozen_string_literal: true

require 'date'
require 'yaml'
require_relative 'lib/access_db'
require_relative 'lib/rules'
require_relative 'lib/statistics'
require_relative 'lib/result_printer'

access_db = AccessDb.new
path = File.dirname(__FILE__)

file_name = "#{path}/db/cars.yml"
file_searches = "#{path}/db/searches.yml"

cars = access_db.read_file(file_name)

File.new(file_searches, 'w') unless File.exist?(file_searches)
read_searches = access_db.read_file(file_searches)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new
statistics = Statistics.new(read_searches || [])

puts 'Please select search rules.'

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

statistics.make_total_quantity(match_cars)
requests_quantity = statistics.make_requests_quantity(search_by_rules.user_answers)
total_statistic = statistics.total_statistic(requests_quantity)

access_db.write_file(total_statistic, file_searches)

puts 'Please choose sort option (date_added|price):'
puts 'Press d if date_added or press p if price'
sort_option = search_by_rules.sort_option(match_cars)

puts 'Please choose sort direction(desc|asc):'
puts 'Press d if desc or press a if asc'
sort_direction = search_by_rules.sort_direction(sort_option)

print_total_statistics = statistics.print_total_statistics(requests_quantity)

printer.print_statics(print_total_statistics)
printer.print_result(sort_direction)
