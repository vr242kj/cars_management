# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require 'i18n'

class SearchExecutor
  FILE_CARS = 'cars'
  FILE_SEARCHES = 'searches'

  attr_reader :database, :cars, :read_searches, :printer, :search_by_rules

  def initialize
    @database = Database.new
    @cars = database.read(FILE_CARS)
    @read_searches = database.read(FILE_SEARCHES, create: true)
    @printer = ResultPrinter.new
    @search_by_rules = Rules.new(cars)
  end

  def call
    statistics = Statistics.new(read_searches)
    search_by_rules.ask_rules
    match_cars = search_by_rules.match_cars
    statistics.make_total_quantity(match_cars)

    requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
    update_statistics(requests_values)

    sort_option = ask_option(search_by_rules, match_cars)
    sort_direction = ask_direction(search_by_rules, sort_option)

    print_total_statistics = statistics.find_statistic(requests_values)

    print_statistic(print_total_statistics)
    print_result(sort_direction)
  end

  private

  def update_statistics(requests_values)
    total_statistic = statistics.total_statistic(requests_values)
    database.write(FILE_SEARCHES, total_statistic)
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

  def print_statistic(print_total_statistics)
    printer.print_statics(print_total_statistics)
  end

  def print_result(sort_direction)
    printer.print_result(sort_direction)
  end
end
