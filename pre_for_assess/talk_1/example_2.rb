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

dogs = [dog_1, dog_2, dog_3]

# 1
# p dogs.reduce { |obj_1, obj_2| obj_1 + obj_2 }

# how to fix this

# dogs.reduce do |obj_1, obj_2|
#   puts "obj_1 is #{obj_1.inspect}"
#   puts "obj_2 is #{obj_2.inspect}"
# end

# dogs.reduce(0) do |obj_1, obj_2|
#   puts "obj_1 is #{obj_1.inspect}"
#   puts "obj_2 is #{obj_2.inspect}"
# end

# dogs = [0, dog_1, dog_2, dog_3]


# remember in the ruby basic course, it emphasises a lot about the return value ?
# Think about what is the return value for every iteration step
# And what the return value is used for?

# Fix for # 1
# p dogs.reduce(0) { |obj_1, obj_2| obj_1 + obj_2.age }
# did we used the `+` method that we difined in the Dog class?
# try comment the method then run again



# Now we know it's just about constantly use the return value of block to update the first block parameter
# then finally return that first parameter

# p [2, 4, 8, 1].max
# p [2, 4, 8, 1].max { |num_1, num_2| num_1 <=> num_2 }
# p %w[one two sixty five].max { |num_1, num_2| num_1.length <=> num_2.length }
#


# p [2, 4, 8, 1].reduce { |num_1, num_2| ? }
# p [2, 4, 8, 1].reduce { |num_1, num_2| num_1 > num_2 ? num_1 : num_2 }

# p %w[one two sixty five].reduce { |num_1, num_2| ? }
# p %w[one two sixty five].reduce { |num_1, num_2| num_1.length > num_2.length ? num_1 : num_2 }
