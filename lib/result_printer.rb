class ResultPrinter
  def print_result(results)
    puts '-' * 20
    puts 'Results:'
    puts

    results.each do |car|
      car.each do |k, v|
        puts "#{k.capitalize}: #{v}"
      end

      puts '-' * 20
    end
  end
end
