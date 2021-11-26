# frozen_string_literal: true

class ResultPrinter
  def print_result(results)
    puts '-' * 20
    puts 'Results:'

    results.each do |car|
      car.each do |k, v|
        puts "#{k.capitalize}: #{v}"
      end

      puts '-' * 20
    end
  end

  def print_statics (print_total_statistics)
    puts '-' * 20
    puts 'Statistic:'
    puts "Total Quantity: #{print_total_statistics[:total_quantity]}"
    puts "Requests quantity: #{print_total_statistics[:requests_quantity]}"
  end
end
