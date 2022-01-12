# frozen_string_literal: true

require_relative 'dependencies'

class Menu
  @@men = %i[log_in sing_up execute_search show_all_cars help exit]
  FILE_CARS = 'cars'

  attr_reader :database, :cars, :printer, :search_executor, :user

  def initialize
    @database = Database.new
    @cars = database.read(FILE_CARS)
    @printer = ResultPrinter.new
    @search_executor = SearchExecutor.new
    @user = User.new
  end

  def show_menu
    loop do
      option_number = select_option
      option_number = Integer(option_number, exception: false).to_i
      if correct_input(option_number)
        send(@@men[option_number - 1])
      else
        puts I18n.t('unexpected_choice_error')
        puts('')
      end
    end
  end

  private

  def select_option
    puts ''
    puts I18n.t('start_message')

    @@men.each_with_index do |menu, index|
      puts "#{index + 1} - " + I18n.t("menu_choices.#{menu}")
    end

    gets.chomp
  end

  def correct_input(option_number)
    (1..@@men.size).cover?(option_number)
  end

  def execute_search
    search_executor.call
  end

  def show_all_cars
    printer.print_all_cars(cars)
    puts('')
  end

  def help
    puts I18n.t('help')
    puts('')
  end

  def log_in
    user.log_in
    @@men.push('log_out')
  end

  def sing_up
    user.sing_up
    @@men.push('log_out')
  end

  def log_out
    @@men.pop
    user.log_out
  end
end
