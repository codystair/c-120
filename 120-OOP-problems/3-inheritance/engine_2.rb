class Vehicle
  def start_engine
    'Ready to go!'
  end
end

class Truck < Vehicle
  def start_engine(speed)
    # "#{Vehicle.new.start_engine} Drive #{speed}, please!"
    super() + "Drive #{speed}, please!"
  end
end

truck1 = Truck.new
puts truck1.start_engine('fast')
