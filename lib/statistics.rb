# frozen_string_literal: true

class Statistics
  def initialize(match_cars)
    @statistic = { total_quantity: match_cars.size, requests_quantity: 1 }
    @search_statistics = []
  end

  def valuable_request_values(user_answers)
    user_answers.inject({}) do |requests, (key, value)|
      requests[key] = value if value != '' && value != 0
      requests
    end
  end

  def total_statistic(request, searches)
    if searches == false
      @search_statistics.push({ search: request, statistics: @statistic })
    else
      searches.each do |record|
        record[:statistics][:requests_quantity] += 1 if record[:search] == request
        @search_statistics.push(record)
      end
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
