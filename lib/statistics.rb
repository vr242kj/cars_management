# frozen_string_literal: true

class Statistics
  attr_reader :searches

  def initialize(searches)
    @searches = searches
    @statistic = { total_quantity: 0, requests_quantity: 1 }
    @search_statistics = []
  end

  def make_total_quantity(match_cars)
    @statistic[:total_quantity] = match_cars.size
  end

  def valuable_request_values(user_answers)
    user_answers.each_with_object({}) do |(key, value), requests|
      requests[key] = value if value != '' && value != 0
      requests
    end
  end

  def total_statistic(request)
    searches.each do |record|
      record[:statistics][:requests_quantity] += 1 if record[:search] == request
      @search_statistics.push(record)
    end

    return @search_statistics if @search_statistics.any? { |h| h.any?([:search, request]) }

    @search_statistics.push({ search: request, statistics: @statistic })
    @search_statistics
  end

  def find_statistic(request)
    car = @search_statistics.find { |h| h[:search] == request }
    car[:statistics]
  end
end
