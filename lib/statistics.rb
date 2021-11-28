# frozen_string_literal: true

#Class for Statistics
class Statistics
  # Initialize search statistics
  # search is data from searches yaml
  def initialize(searches)
    @searches = searches
    @statistic = { total_quantity: 0, requests_quantity: 1 }
    @search_statistics = []
  end

  # Set total quantity of cars from user request
  def make_total_quantity(match_cars)
    @statistic[:total_quantity] = match_cars.size
  end

  # Filter for only fiiled up fields from user request
  def make_requests_quantity(user_answers)
    requests  = {}

    user_answers.each do |k, v|
      requests[k] = v if v != '' && v != 0
    end

    requests
  end

  # Set total statistic
  # :search:
  #   make: ford
  # :statistic:
  #   :total_quantity: 2
  #   :requests_quantity: 1
  def total_statistic(request)
    @searches.each do |record|
      record[:statistics][:requests_quantity] += 1 if record[:search] == request
      @search_statistics.push(record)
    end

    return @search_statistics if @search_statistics.map { |h| h.any?([:search, request]) }.include?(true)

    @search_statistics.push({ search: request, statistics: @statistic  })
    @search_statistics
  end

  # Set statistic hash for printing result
  # { total_quantity: 2, requests_quantity: 1 }
  def print_total_statistics(request)
    car = @search_statistics.find { |h| h[:search] == request }
    car[:statistics]
  end
end

