# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require 'i18n'

class Menu
  MENU = { search_a_car: 1, show_all_cars: 2, help: 3, exit: 4 }.freeze
  FILE_CARS = 'cars'
  FILE_SEARCHES = 'searches'

  def initialize
    @database = Database.new
    @cars = @database.read(FILE_CARS)
    @read_searches = @database.read(FILE_SEARCHES, create: true)
  end

  def show_menu
    puts I18n.t('greeting')
    loop do
      option_number = select_option
      correct_input(option_number)

      MENU.each do |key, value|
        send(key) if value == option_number
      end

      break if option_number == MENU[:exit]
    end
  end

  def select_option
    puts I18n.t('start_message')

    MENU.each do |key, value|
      puts "#{value} - " + I18n.t("menu_choices.#{key}")
    end

    gets.chomp.to_i
  end

  def correct_input(option_number)
    puts I18n.t('unexpected_choice_error') if option_number < 1 || option_number > MENU.size
    puts('')
  end

  def search_a_car
    search_by_rules = Rules.new(@cars)
    statistics = Statistics.new(@read_searches)

    search_by_rules.ask_rules unless search_by_rules.finished?

    match_cars = search_by_rules.match_cars

    statistics.make_total_quantity(match_cars)
    requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
    total_statistic = statistics.total_statistic(requests_values)

    @database.write(FILE_SEARCHES, total_statistic)

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
    printer = ResultPrinter.new
    printer.print_statics(print_total_statistics)
    printer.print_result(sort_direction)
  end

  def show_all_cars
    printer = ResultPrinter.new
    printer.print_all_cars(@cars)
    puts('')
  end

  def help
    puts I18n.t('help')
    puts('')
  end
end
