# You have the following classes.

module Walkable
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def walk
    p "#{name} #{gait}s forward."
  end
end

class Noble
  include Walkable
  attr_reader :title

  def initialize(name, title)
    super(name)
    @title = title
  end

  def name
    "#{@title} #{@name}"
  end

  private

  def gait
    "strut"
  end
end

class Person
  include Walkable
  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable
  private

  def gait
    "saunters"
  end
end

class Cheetah
  include Walkable
  private

  def gait
    "runs"
  end
end
# You need to modify the code so that this works:

mike = Person.new("Mike")
mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk

byron.name

byron.title
