class Rules
  SEARCH_RULES = %w[make model year_from year_to price_from price_to]

  def initialize
    @current_question = 0
    @user_answers = {}
  end

  def ask_rules
    SEARCH_RULES.each do |rule|
      puts "Please choose #{rule}:"

      user_input = gets.chomp

      if rule.include?('year') || rule.include?('price')
        user_input = user_input.to_i
      end

      @user_answers[rule] = user_input

      @current_question += 1
    end
  end

  def find_equal(cars)
    search_results = []
    cars.each do |car|
      correct = 0
      car.each_pair do |k, v|
        if k == 'make' && @user_answers[k].downcase == v.downcase
          correct += 1
        end
        if k == 'model' && @user_answers[k].downcase == v.downcase
          correct += 1
        end
        if k == 'year' && @user_answers[k + '_from'] <= v.to_i
          correct += 1
        end
        if k == 'price' && @user_answers[k + '_from'] <= v.to_i
          correct += 1
        end
        if k == 'year' && @user_answers[k + '_to'] >= v.to_i
          correct += 1
        end
        if k == 'price' && @user_answers[k + '_to'] >= v.to_i
          correct += 1
        end
        if correct == 6
          search_results << car
          break
          end
      end
    end

    return search_results
  end

  def finished?
    @current_question >= SEARCH_RULES.size
  end
end
