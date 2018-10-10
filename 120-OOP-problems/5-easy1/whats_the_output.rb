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

name = 'Fluffy' # => 'Fluffy'
fluffy = Pet.new(name) # return a Pet object that contains `@name='Fluffy'`
puts fluffy.name # puts('Fluffy') => Fluffy
puts fluffy
# 1 @name.upcase! => 'FLUFFY'
# 2 "My name is FLUFFY."
# => "My name is FLUFFY."

puts fluffy.name # => FLUFFY
puts name # => 'FLUFFY'
