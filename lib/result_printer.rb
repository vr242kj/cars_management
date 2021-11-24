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

  def print_statics (total_quantity, req_quantity)

    puts '-' * 20
    puts 'Statistic:'
    puts "Total Quantity: #{total_quantity}"
    puts "Requests quantity: #{req_quantity}"
  end
end
