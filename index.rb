# frozen_string_literal: true
require_relative 'lib/database'
require_relative 'lib/rules'
require_relative 'lib/result_printer'
require_relative 'lib/statistics'
require 'i18n'

puts "Enter language (en|ua)"
lang_input = gets.chomp.downcase
lang_input = 'ua' if lang_input != 'en' || lang_input != 'ua'

I18n.load_path << Dir[File.expand_path("config/locales") + "/#{lang_input}.yml"]

database = Database.new

file_cars = 'cars'
file_searches = 'searches'

cars = database.read(file_cars)

read_searches = database.read(file_searches, true)

search_by_rules = Rules.new(cars)
printer = ResultPrinter.new

puts I18n.t(:start_message)

search_by_rules.ask_rules unless search_by_rules.finished?

match_cars = search_by_rules.match_cars

statistics = Statistics.new(match_cars)

requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
total_statistic = statistics.total_statistic(requests_values, read_searches)
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