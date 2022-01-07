# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require 'i18n'

class Menu
  MENU = ['Search a car', 'Show all cars', 'Help', 'Exit'].freeze

  def initialize
    @file_cars = 'cars'
    @file_searches = 'searches'
  end

  def show_menu
    puts 'Welcome'
    loop do
      MENU.each_with_index do |menu, index|
        puts "#{index + 1} - #{menu}"
      end

      puts 'Select the option (write the number): '
      option_number = gets.chomp.to_i
      correct_input(option_number)

      search_car if option_number == 1

      show_all_cars if option_number == 2

      help if option_number == 3

      break if option_number == 4
    end
  end

  def correct_input(option_number)
    # return 'Unexpected choice' unless MENU.each_index.any?(option_number)
    puts 'Unexpected choice' unless MENU.map { |x| MENU.index(x) + 1 == option_number }.any?
  end

  def search_car
    database = Database.new
    cars = database.read(@file_cars)
    read_searches = database.read(@file_searches, create: true)

    search_by_rules = Rules.new(cars)
    printer = ResultPrinter.new
    statistics = Statistics.new(read_searches)
    search_by_rules.ask_rules unless search_by_rules.finished?

    match_cars = search_by_rules.match_cars

    statistics.make_total_quantity(match_cars)
    requests_values = statistics.valuable_request_values(search_by_rules.user_answers)
    total_statistic = statistics.total_statistic(requests_values)

    database.write(@file_searches, total_statistic)

    puts I18n.t('sort_fields.option')
    puts I18n.t('sort_fields.option_letter')
    sort_option = search_by_rules.sort_option(match_cars)

    puts I18n.t('sort_fields.direction')
    puts I18n.t('sort_fields.direction_letter')
    sort_direction = search_by_rules.sort_direction(sort_option)

    print_total_statistics = statistics.find_statistic(requests_values)

    printer.print_statics(print_total_statistics)

    printer.print_result(sort_direction)
  end

  def show_all_cars
    database = Database.new
    printer = ResultPrinter.new
    cars = database.read(@file_cars)
    printer.show_all_cars(cars)
  end

  def help
    puts I18n.t('help')
  end
end
