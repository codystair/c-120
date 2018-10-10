# class Person
#   attr_accessor :first_name
#   attr_writer :last_name
#
#   def first_equals_last?
#     first_name == @last_name
#   end
# end
#
# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?
# p person1.last_name

# standard solution

# class Person
#   attr_accessor :first_name
#   attr_writer :last_name
#
#   def first_equals_last?
#     first_name == last_name
#   end
#
#   private
#
#   attr_reader :last_name
# end

# possible
#
# class Person
#   attr_accessor :first_name
#   attr_writer :last_name
#
#   def first_equals_last?
#     first_name == last_name
#   end
#
#   protected
#
#   attr_reader :last_name
# end
#
# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?
# p person1.last_name
require 'pry'

class Person
  attr_accessor :first_name
  attr_writer :last_name

  def first_equals_last?
    binding.pry
    first_name == @lasst_name
  end
end

person1 = Person.new

person1.first_name = 'john'
person1.last_name = 'john'

p person1.first_equals_last?
