# As you know by now, classes are the blueprints for objects. Below are some practice problems that test your knowledge of the connection between classes and objects.
#
# Given the below usage of the Person class, code the class definition.
#
# bob = Person.new('bob')
# bob.name                  # => 'bob'
# bob.name = 'Robert'
# bob.name                  # => 'Robert'

# 1 initialize(name) method exists
# 2 reader(getter) method exsits
# 3 writter(setter) method exists
# 4 Person objects only has one attribute -- name
class Person
  attr_accessor :name

  def initialize(name)
    self.name = name
    # @name = name
  end
end


# Modify the class definition from above to facilitate the following methods. Note that there is no name= setter method now.
#
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'
# Hint: let first_name and last_name be "states" and create an instance method called name that uses those states.
#

# 1 initialize(first_name) method exists
# 2 there exists name attribute and a reader method for it
# 3 exists a method `first_name` it will return the value of the name attribute
# 4 exists a method 'last_name' it will return some last name =>
    # there's a @last_name
    # there a setter method for last_name
    # last_name has a default value which is a empty string which should be set during initializing
# 5 reader method 'name' is exactly return the combination of first_name and last_name
# Summary
  # States
    # :name => only reader(not original version) => combination of first and last name
    # :first_name => only reader
    # :last_name => reader and writter
  # behavior
    # initialize => takes first_name => set first_name and default last_name("")

class Person
  attr_accessor :last_name
  attr_reader :first_name

  def initialize(first_name)
    @first_name = first_name
    @last_name = ""
  end

  def name
    # last_name ? @first_name + " " + last_name : @first_name
    # strip → new_str click to toggle source Returns a copy of str with leading and trailing whitespace removed.
    (@first_name + " " + @last_name).strip
  end
end

# Now create a smart name= method that can take just a first name or a full name, and knows how to set the first_name and last_name appropriately.
#
# bob = Person.new('Robert')
# bob.name                  # => 'Robert'
# bob.first_name            # => 'Robert'
# bob.last_name             # => ''
# bob.last_name = 'Smith'
# bob.name                  # => 'Robert Smith'
#
# bob.name = "John Adams"
# bob.first_name            # => 'John'
# bob.last_name             # => 'Adams'

# States:
  # :name => smart name=(first_name or full_name but not just last_name)
    # customized getter and setter method
  # :first_name => reader method
  # :last_name => setter and getter methods
# Behavior
  # :initialize(first_name) while setting the last_name to defualt ""

class Person
  attr_accessor :last_name
  attr_reader :first_name

  def initialize(first_name)
    @first_name = first_name
    @last_name = ""
  end

  def name=(name)
    if name.include?(" ")
      @first_name, @last_name = name.split(" ")
    else
      @first_name = name
    end
  end

  def name
    (@first_name + " " + @last_name).strip
  end

  def to_s
    name
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

# Using the class definition from step #3, let's create a few more people -- that is, Person objects.
#
# bob = Person.new('Robert Smith')
# rob = Person.new('Robert Smith')
# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?
#
#
# Continuing with our Person class definition, what does the below print out?
#
# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"
#
# Let's add a to_s method to the class:
#
# class Person
#   # ... rest of class omitted for brevity
#
#   def to_s
#     name
#   end
# end
# Now, what does the below output?
#
# bob = Person.new("Robert Smith")
# puts "The person's name is: #{bob}"
