# frozen_string_literal: true

require_relative 'lib/database'
require_relative 'lib/rules'
require_relative 'lib/result_printer'
require_relative 'lib/statistics'
require_relative 'lib/language'
require 'i18n'

language = Language.new
language.ask_language

database = Database.new

file_cars = 'cars'
file_searches = 'searches'

cars = database.read(file_cars)

read_searches = database.read(file_searches, create: true)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new
statistics = Statistics.new(read_searches)

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

statistics.make_total_quantity(match_cars)
requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
total_statistic = statistics.total_statistic(requests_values)

database.write(file_searches, total_statistic)

puts I18n.t('sort_fields.option')
puts I18n.t('sort_fields.option_letter')
sort_option = search_by_rules.sort_option(match_cars)

puts I18n.t('sort_fields.direction')
puts I18n.t('sort_fields.direction_letter')
sort_direction = search_by_rules.sort_direction(sort_option)

print_total_statistics = statistics.find_statistic(requests_values)

printer.print_statics(print_total_statistics)

printer.print_result(sort_direction)
