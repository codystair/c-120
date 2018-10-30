class Dog
  attr_reader :age
  def initialize(age)
    @age = age
  end

  def +(another)
    age + another.age
  end
end

dog_1 = Dog.new(1)
dog_2 = Dog.new(2)
dog_3 = Dog.new(3)

# 1
# puts dog_1 + dog_2
# puts ''
# puts dog_2 + dog_3

# 2 ?
# dog_1 + dog_2 + dog_3


# actually, the real thing happened
#
# dog_1.+(dog_2).+(dog_3)

# p dog_1.+(dog_2) # => 3
# 3.+(dog_3)
