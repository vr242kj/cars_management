# frozen_string_literal: true

class Statistics

  def initialize
    @statistic = { total_quantity: 0, requests_quantity: 1 }
    @search_statistics = []
  end

  def make_total_quantity(match_cars)
    @statistic[:total_quantity] = match_cars.size
  end

  def make_requests_quantity(user_answers)
    requests  = {}

    user_answers.each do |k, v|
      requests[k] = v if v != '' && v != 0
    end

    requests
  end

  def total_statistic(request, searches)
    if searches == false
      @search_statistics.push({ search: request, statistics: @statistic  })
    else
      searches.each do |record|
        record[:statistics][:requests_quantity] += 1 if record[:search] == request
        @search_statistics.push(record)
      end
    end

    return @search_statistics if @search_statistics.map { |h| h.any?([:search, request]) }.include?(true)

    @search_statistics.push({ search: request, statistics: @statistic  })
    @search_statistics
  end

  def print_total_statistics(request)
    car = @search_statistics.find { |h| h[:search] == request }
    car[:statistics]
  end
end

