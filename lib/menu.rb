# frozen_string_literal: true

require_relative 'database'
require_relative 'rules'
require_relative 'result_printer'
require_relative 'statistics'
require_relative 'language'
require_relative 'executor'
require 'i18n'

class Menu
  MENU = %i[search_a_car show_all_cars help exit].freeze
  FILE_CARS = 'cars'

  def initialize
    @database = Database.new
    @cars = @database.read(FILE_CARS)
    @printer = ResultPrinter.new
    @executor = Executor.new
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

  def select_option
    puts I18n.t('start_message')

    MENU.each_with_index do |menu, index|
      puts "#{index + 1} - " + I18n.t("menu_choices.#{menu}")
    end

    gets.chomp.to_i
  end

  def correct_input(option_number)
    puts I18n.t('unexpected_choice_error') unless MENU.map { |x| MENU.index(x) + 1 == option_number }.any?
    puts('')
  end

  def search_a_car
    @executor.search_a_car
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
