def separator
  puts "\n\n"
  puts " - " * 30
  puts "\n\n"
end

def in_the_block
  puts "In the block!".center(30, ' - ')
end


# It's all about using the return value of every block to constantly update the
# first block argument
# The return value of method invocation is the final value of starting_obj

# ------------------------------------------------------------------------------

# # Normal uses of inject/reduce
#
# p (1..3).inject { |starting_obj, next_obj| starting_obj + next_obj }
#
# # Dismantle
#
# # show objects in every block calling but didn't change the return value of the block
# (1..3).inject do |starting_obj, next_obj|
#   in_the_block
#   p [starting_obj, next_obj]
#   starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

# p (1..3).inject(9) { |starting_obj, next_obj| starting_obj + next_obj }

# Dismantle
# When we provide an object as the starting_obj,
# the block arguments now are pointing to different objects

# (1..3).inject(9) do |starting_obj, next_obj|
#   in_the_block
#   p [starting_obj, next_obj]
#   starting_obj + next_obj
# end

# alternative syntax
# (1..3).inject(9, :+) do |starting_obj, next_obj|
#    p starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

# (1..3).inject(9) do |starting_obj, next_obj|
#   in_the_block
#   p [starting_obj, next_obj]
#   starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

# class Dog
# end
#
# dogs = []
#
# 3.times { dogs << Dog.new }

# ------------------------------------------------------------------------------

# dogs.inject do |starting_obj, next_obj|
#   starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

# dogs.inject do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

# dogs.inject(3) do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj
# end

# ------------------------------------------------------------------------------

class Dog
  attr_reader :age
  def initialize(age)
    @age = age
  end
end

dogs = []

3.times { dogs << Dog.new(rand(10)) }

# dogs.inject do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj.age + next_obj.age
# end

# ------------------------------------------------------------------------------

# dogs.inject(0) do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj.age
# end

# the return value of the whole expression is the final value of starting_obj
# so the last result didn't show

# ------------------------------------------------------------------------------

# result =
# dogs.inject(0) do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj.age
# end
#
# p result

# ------------------------------------------------------------------------------

class Dog
  def +(other)
    age + other.age
  end
end
#
# result =
# dogs.inject do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj
# end
#
# p result

# at the 1st block, things went ok
# but why things went wrong at the 2nd block
  # in the second block starting_obj has updated to a integer
  # so in the second block the `+` method is called from Integer lookup path
  # not the one we defined in the Dog class
# so the safe syntax is `starting_obj + next_obj.age`

# ------------------------------------------------------------------------------

# result =
# dogs.inject(0) do |starting_obj, next_obj|
#   in_the_block
#   p starting_obj, next_obj
#   starting_obj + next_obj.age
# end
#
# p result

# ------------------------------------------------------------------------------

result =
dogs.inject do |starting_obj, next_obj|
  in_the_block
  p starting_obj, next_obj
  Dog.new(starting_obj.age + next_obj.age)
end

p result



# ------------------------------------------------------------------------------

# It's all about using the return value of every block to constantly update the
# first block argument
# The return value of method invocation is the final value of starting_obj
