# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require 'i18n'

class Executor
  FILE_CARS = 'cars'
  FILE_SEARCHES = 'searches'

  attr_reader :database, :cars, :read_searches, :printer

  def initialize
    @database = Database.new
    @cars = database.read(FILE_CARS)
    @read_searches = database.read(FILE_SEARCHES, create: true)
    @printer = ResultPrinter.new
  end

  def search_a_car
    search_by_rules = Rules.new(cars)
    statistics = Statistics.new(read_searches)
    search_by_rules.ask_rules unless search_by_rules.finished?
    match_cars = search_by_rules.match_cars
    statistics.make_total_quantity(match_cars)
    requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
    total_statistic = statistics.total_statistic(requests_values)
    database.write(FILE_SEARCHES, total_statistic)
    sort_option = ask_option(search_by_rules, match_cars)
    sort_direction = ask_direction(search_by_rules, sort_option)

    print_total_statistics = statistics.find_statistic(requests_values)
    print_serched_car(print_total_statistics, sort_direction)
  end

  def ask_option(search_by_rules, match_cars)
    puts I18n.t('sort_fields.option')
    puts I18n.t('sort_fields.option_letter')
    search_by_rules.sort_option(match_cars)
  end

  def ask_direction(search_by_rules, sort_option)
    puts I18n.t('sort_fields.direction')
    puts I18n.t('sort_fields.direction_letter')
    search_by_rules.sort_direction(sort_option)
  end

  def print_serched_car(print_total_statistics, sort_direction)
    printer.print_statics(print_total_statistics)
    printer.print_result(sort_direction)
  end
end
