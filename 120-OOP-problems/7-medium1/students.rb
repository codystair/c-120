class Student
  def initialize(name=nil, year=nil)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end
end

class Undergraduate < Student
end

class Dropout < Student
  def initialize
    super()
  end
end

p Undergraduate.new("Bob", 3)
p Dropout.new
