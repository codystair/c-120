class Cat
  attr_accessor :name, :color
  COLORS = %w(white blue red yellow black pink grey green)

  def initialize(name)
    @name = name
    @color = COLORS.sample
  end

  def greet
    puts "Hello! My name is #{name} and I am a #{color} cat!"
  end
end


kitty = Cat.new('Sophie')
kitty.greet
