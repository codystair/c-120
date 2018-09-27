# class Cat
#   attr_accessor :name
#
#   def initialize(name)
#     @name = name
#   end
#
#   def identify
#     self
#   end
# end
#
# kitty = Cat.new('Sophie')
# p kitty.identify

class Cat
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.generic_greeting
    puts "Hello! I am a #{self.name}"
  end

  def personal_greeting
    puts "Hello! My name is #{name}"
  end
end

kitty = Cat.new('Sophie')

Cat.generic_greeting
kitty.personal_greeting
