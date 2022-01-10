# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require_relative 'search_executor'
require 'i18n'

class Menu
  MENU = %i[execute_search show_all_cars help exit].freeze
  FILE_CARS = 'cars'

  attr_reader :database, :cars, :printer, :executor

  def initialize
    @database = Database.new
    @cars = database.read(FILE_CARS)
    @printer = ResultPrinter.new
    @executor = SearchExecutor.new
  end

  def show_menu
    puts I18n.t('greeting')
    loop do
      option_number = select_option
      correct_input(option_number)

      MENU.each_with_index  do |menu, index|
        send(menu) if index == option_number - 1
      end
    end
  end

  private

  def select_option
    puts I18n.t('start_message')

    MENU.each_with_index do |menu, index|
      puts "#{index + 1} - " + I18n.t("menu_choices.#{menu}")
    end

    gets.chomp.to_i
  end

  def correct_input(option_number)
    puts I18n.t('unexpected_choice_error') if option_number < 1 || option_number > MENU.size
    puts('')
  end

  def execute_search
    executor.call
  end

  def show_all_cars
    printer = ResultPrinter.new
    printer.print_all_cars(cars)
    puts('')
  end

  def help
    puts I18n.t('help')
    puts('')
  end
end
