class Statistic

  attr_reader :quantity

  def initialize
    @quantity = 0
  end

  def requests_quantity(searches, user_answers)

    searches.each do |hash|
      @quantity += 1 if hash == user_answers
    end

    @quantity
  end

  def total_quantity(sort_direction)

    sort_direction.length
  end
end
