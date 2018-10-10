class Vehcile
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    case self.class.to_s
    when 'Car'
      return 4
    when 'Motorcycle'
      return 2
    when 'Truck'
      return 6
    end
    "This type has no wheel!!!"
  end
end

class Car < Vehcile
  # def wheels
  #   4
  # end
end

class Motorcycle < Vehcile
  # def wheels
  #   2
  # end
end

class Truck < Vehcile
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  # def wheels
  #   6
  # end
end

class Boat < Vehcile
end

t = Truck.new('Ford', 'S', 100)
puts t.wheels

b = Boat.new("Lexus", "Med")
puts b.wheels
