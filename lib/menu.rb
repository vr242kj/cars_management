# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require_relative 'search'
require 'i18n'

class Menu
  MENU = { search_a_car: 1, show_all_cars: 2, help: 3, exit: 4 }.freeze
  FILE_CARS = 'cars'

  def initialize
    @database = Database.new
    @cars = @database.read(FILE_CARS)
    @printer = ResultPrinter.new
    @search = Search.new
  end

  def show_menu
    puts I18n.t('greeting')
    loop do
      option_number = select_option
      correct_input(option_number)

      MENU.each do |key, value|
        send(key) if value == option_number
      end
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
    @search.search_a_car
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
