require 'date'

class Rules
  SEARCH_RULES = %w[make model year_from year_to price_from price_to].freeze

  attr_reader :cars, :current_question, :user_answers

  def initialize(cars)
    @cars = cars
    @current_question = 0
    @user_answers = {}
  end

  def ask_rules
    SEARCH_RULES.each do |rule|
      puts I18n.t("search_fields.#{rule}")

      user_input = gets.chomp.downcase

      user_input = user_input.to_i if rule.match?(/year|price/)

      user_answers[rule] = user_input

      @current_question += 1
    end
  end

  def match_cars
    results = []

    cars.each do |car|
      results << car if match_make(car) && match_model(car) && match_year(car) && match_price(car)
    end

    results
  end

  def sort_option(match_cars)
    user_input = gets.chomp.downcase

    if user_input == 'p'
      match_cars.sort_by { |car| car['price'] }
    else
      match_cars.sort_by { |car| Date.strptime(car['date_added'], '%d/%m/%y') }
    end
  end

  def sort_direction(sort_option)
    user_input = gets.chomp.downcase

    if user_input == 'a'
      sort_option
    else
      sort_option.reverse
    end
  end

  def finished?
    @current_question >= SEARCH_RULES.size
  end

  private

  def match_make(car)
    user_answers['make'].empty? || car['make'].downcase == user_answers['make']
  end

  def match_model(car)
     user_answers['model'].empty? || car['model'].downcase == user_answers['model']
  end

  def match_year(car)
    user_answers['year_to'].zero? || car['year'].between?(user_answers['year_from'], user_answers['year_to'])
  end

  def match_price(car)
    user_answers['price_to'].zero? || car['price'].between?(user_answers['price_from'], user_answers['price_to'])
  end
end
