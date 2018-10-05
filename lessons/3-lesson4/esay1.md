## Practice Problems: Easy 1
Question 1

Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

```ruby
true
"hello"
[1, 2, 3, "happy days"]
142
```

- answer
everything is object in Ruby. If we wanna find out what class an object belongs to, we can use `object.class`

Question 2

If we have a Car class and a Truck class and we want to be able to go_fast, how can we add the ability for them to go_fast using the module Speed? How can you check if your Car or Truck can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

- answer
1 `include Speed` module into both of the two classes.
2 `Car.new.go_fast` or `Truck.new.go_fast`

Question 3

In the last question we had a module called Speed which contained a go_fast method. We included this module in the Car class as shown below.
```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the go_fast method from an instance of the Car class (as shown below) you might have noticed that the string printed when we go fast includes the name of the type of vehicle we are using. How is this done?

```ruby
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```

- answer
That's because in method definition of `go_fast`, we call `self.class`, this will print out the class of the object that're calling `go_fast`

Question 4

If we have a class AngryCat how do we create a new instance of this class?

The AngryCat class might look something like this:
```ruby
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
```

- answer
`AngryCat.new`

Question 5

Which of these two classes has an instance variable and how do you know?
```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

- answer
In `Pizza` class, because the way we construct an instance varaible is prepending an `@` mark before a varaible name.

Question 6

What could we add to the class below to access the instance variable @volume?
```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

- answer
1 if we just wanna read the value of the `@volume` instance variable, we just need add a reader/getter method for this attribute. In order to do this, we have two ways:
More manual way: `def value; @volume; end`
Shortcut way: `attr_reader :volume`

2 if we just wanna write the value of the `@volume`, we also have two ways to do this:
More manual way: `def volume=(value); @volume = volume; end`
Shortcut way: `attr_writer :volume`

3 if we wanna have these two things simultaneously, we should add the two methods--both reader/setter--we wrote above, or we can just use one-line shortcut:
`attr_accessor :volume`

Question 7

What is the default return value of to_s when invoked on an object? Where could you go to find out if you want to be sure?

- answer
Ruby's default `to_s` behavior is to print out a string which contains the object's class name and its encoded numbers for its object id. Notice this will not include the instance variables this object contains, which `object.inspect` does.

Question 8

If we have a class such as the one below:
```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

You can see in the make_one_year_older method we have used self. What does self refer to here?

- answer
`make_one_year_older` is an instance method, so inside this method definition, `self`'s meaning is depending on the context, here the context is an instance of a Cat object, so `self` here is representing any instance of Cat class.

Question 9

If we have a class such as the one below:
```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

In the name of the cats_count method we have used self. What does self refer to in this context?
- answer
In this case, when we are defining this method, more specifically, when we are writing `self`, we were inside the class definition of Cat, so `self` here is referencing to the Cat class itself.

Question 10

If we have the class below, what would you need to call to create a new instance of this class.
```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```

- answer
`Bag.new('red', 'wood')`
