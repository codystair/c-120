class Truck
  include Towable
end

class Car
end

module Towable
  def tow
    puts "I can tow a trailer!"
  end
end

truck1 = Truck.new
truck1.tow
