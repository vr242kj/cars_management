class ResultPrinter
  def print_result(results, req_quantity)
    puts '-' * 20
    puts 'Statistic:'

    puts "Total Quantity: #{results.length}"
    puts "Requests quantity: #{req_quantity}"
    puts '-' * 20

    puts 'Results:'

    results.each do |car|
      car.each do |k, v|
        puts "#{k.capitalize}: #{v}"
      end

      puts '-' * 20
    end
  end
end
