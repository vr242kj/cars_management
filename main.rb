require_relative 'cars'
require_relative 'car1'
require 'date'

=begin
a = Cars.new
a.search_options
a.select_cars
a.sort_options
print(a)
=end

data = YAML.load_file('cars.yml')
@size = data.size
@cars_array = []
data.each do |d|
    @cars_array.push(Car1.new(*d.values))
end

@search_rules = []

def search
end




def search_options
    @search_rules = {
      'make' => nil,
      'model' => nil,
      'year_from' => -1,
      'year_to' => -1,
      'price_from' => -1,
      'price_to' => -1
    }

    puts 'Please select search rules. '

    @search_rules.each_key do |x|
        puts "Please choose #{x}"
        temp = gets.chomp("\n")

        if temp == ''
            next
        end

        if temp.match?(/\d/)
            int_temp = temp.to_i
            @search_rules[x] = int_temp
        else
            @search_rules[x] = temp
        end

    end


end

search_options()

