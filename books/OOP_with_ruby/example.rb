class Parent
  def say_hi
    p "Hi from Parent!"
  end
end

class Child < Parent
  def say_hi
    p "Hi from Child!"
  end
end

c = Child.new
p c.instance_of?(Child)
p c.instance_of?(Parent)
