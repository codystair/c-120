class Vehicle
  attr_reader :year

  def initialize(year)
    start_engine
    @year = year
  end
end

class Truck < Vehicle
  def start_engine
    puts 'Ready to go!'
  end
end

truck1 = Truck.new(1994)
puts truck1.year
