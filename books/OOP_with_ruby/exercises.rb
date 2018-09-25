# Create a class called MyCar. When you initialize a new instance or object of the class,
# allow the user to define some instance variables that tell us the year, color,
# and model of the car. Create an instance variable that is set to 0 during
# instantiation of the object to track the current speed of the car as well.
# Create instance methods that allow the car to speed up, brake, and shut the car off.
#

# Add an accessor method to your MyCar class to change and view the color of your car.
# Then add an accessor method that allows you to view, but not modify, the year of your car.
#
# You want to create a nice interface that allows you to accurately describe the
# action you want your program to perform. Create a method called spray_paint that
# can be called on an object and will modify the color of the car.

# class MyCar
#   attr_accessor :color
#   attr_reader :year
#
#   def initialize(year, color, model, speed=0)
#     @year = year
#     @color = color
#     @model = model
#     @speed = speed
#   end
#
#   def speed_up
#     @speed += 1
#     puts "Your car is speed up to #{@speed} km/h"
#   end
#
#   def brake
#     @speed -= 1
#     puts "Your car is slow down to #{@speed} km/h"
#   end
#
#   def shut
#     @speed = 0
#     puts "You stopped the car."
#   end
#
#   def spray_paint(new_color)
#     self.color = new_color
#     puts "You just painted your car to a new color => #{color}, have a look!"
#   end
# end
#
# my_car = MyCar.new(1999, "red", "Honda")
# 3.times { my_car.speed_up }
# my_car.brake
# my_car.shut
# my_car.spray_paint("Black")


# --------------------------------------------------------------------------------

# Add a class method to your MyCar class that calculates the gas mileage of any car.
#
# Override the to_s method to create a user friendly print out of your object.

# module SuperPower
#   def dive
#     p "Look! I am under the water!"
#   end
# end
#
# class Vehicle
#   attr_accessor :color
#   attr_reader :year, :model, :speed
#   @@total_vehicles = 0
#
#   def initialize(year, color, model, speed=0)
#     @year = year
#     @color = color
#     @model = model
#     @speed = speed
#     @@total_vehicles += 1
#   end
#
#   def self.report_number_of_vehicles
#     p "The total number of both MyCars and MyTrucks is #{@@total_vehicles}"
#   end
#
#   def self.gas_mileage(gallons, miles)
#     puts "#{miles / gallons} miles per gallon."
#   end
#
#   def speed_up
#     @speed += 1
#     puts "Your car is speed up to #{@speed} km/h"
#   end
#
#   def brake
#     @speed -= 1
#     puts "Your car is slow down to #{@speed} km/h"
#   end
#
#   def shut
#     @speed = 0
#     puts "You stopped the car."
#   end
#
#   def spray_paint(new_color)
#     self.color = new_color
#     puts "You just painted your car to a new color => #{color}, have a look!"
#   end
#
#   def to_s
#     "Your shining #{age} years old #{color} #{model} car which is made in #{year} now is flying at the speed of #{speed} km/h!"
#   end
#
#   private
#
#   def age
#     current_year = Time.new.year
#     age = current_year - year
#   end
# end
#
# class MyCar < Vehicle
#   include SuperPower
#   NUMBER_OF_SEATS = 8
# end
#
# class MyTruck < Vehicle
#   LOADING_CAPA = 72
# end

# puts my_car1 = MyCar.new(2000, "blue", "Bench")
# puts my_car2 = MyCar.new(1999, "red", "Honda")
#
#
# puts my_truck1 = MyTruck.new(2001, "black", "Toyoto")
# puts my_truck2 = MyTruck.new(2002, "yellow", "Ford")
# Vehicle.report_number_of_vehicles

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def better_grade_than?(other)
    self.grade > other.grade
  end

  protected

  def grade
    @grade
  end
end

# s1 = Student.new("Wendy", 8)
# s2 = Student.new("Mark", 3)
# p s1.better_grade_than?(s2)
#

class Person
  def hi
  end
end

bob = Person.new
bob.hi


# --------------------------------------------------------------------------------
