class Car
  attr_accessor :id, :make, :model,
                :year, :odometer,
                :price, :description,
                :date_added

  def initialize(id, make, model, year, odometer, price, description, date_added)
    @id = id
    @make = make
    @model = model
    @year = year
    @price = price
    @date_added = date_added
    @odometer = odometer
    @description = description
  end

  def to_s
    "
    Id: #{@id}\n
    Make: #{@make}\n
    Model: #{@model}\n
    Year: #{@year}\n
    Price: #{@price}\n
    Date added: #{@date_added}\n
    Odometer: #{@odometer}\n
    Description: #{@description}\n
    ___________________________________
    "
  end
end
