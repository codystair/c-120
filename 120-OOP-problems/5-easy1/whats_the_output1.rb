class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name) # return a Pet object that contains `@name='42'`
name += 1 # return 43 and the local variable `name` now is pointing to 43
puts fluffy.name # puts('42') => 42
puts fluffy
# '42'.upcase! => nil
  # @name='42'
# My name is 42.

puts fluffy.name # => 42
puts name # 43
