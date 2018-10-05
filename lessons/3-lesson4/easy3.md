## Practice Problems: Easy 3

Question 1

If we have this code:
```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
What happens in each of the following cases:

case 1:
```ruby
hello = Hello.new # create a new Hello object and store it in local variable `hello`
hello.hi # call `hi` on the hello object
# =>Hello
# =>nil
```

case 2:
```ruby
hello = Hello.new
hello.bye
# raise an exception
# undefined method `bye` for Hello object
```

case 3:
```ruby
hello = Hello.new
hello.greet # lack of an argument
# raise an exception: wrong number of arguments, require 1 and passing 0
```

case 4:
```ruby
hello = Hello.new
hello.greet("Goodbye")
# found the `greet` method in Hello's superclass
# => Goodbye
# => nil
```

case 5:
```ruby
Hello.hi # raise an exception
# undefined method `hi` for Hello class
```

Question 2

In the last question we had the following classes:
```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```
If we call Hello.hi we get an error message. How would you fix this?

- answer
We can define a new class method in Hello class:
```ruby
def self.hi
 # do something here
end
```

Question 3

When objects are created they are a separate realization of a particular class.

Given the class below, how do we create two different instances of this class, both with separate names and ages?

```ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

- answer
Call `AngryCat.new("age", "name")` two times, each time just passing in different arguments

Question 4

Given the class below, if we created a new instance of the class and then called to_s on that instance we would get something like "#<Cat:0x007ff39b356d30>"

```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

How could we go about changing the to_s output on this method to look like this: I am a tabby cat? (this is assuming that "tabby" is the type we passed in during initialization).

- answer
```ruby
def to_s
  "I am a #{@type} cat."
end
```

Question 5

If I have the following class:
```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

What would happen if I called the methods like shown below?
```ruby
tv = Television.new
tv.manufacturer # raise an excetpion: undefined method manufacturer for Television instance
tv.model # execute model method

Television.manufacturer # execute manufacturer method
Television.model # raise an exception: undefined method `model` for Television class
```

Question 6

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

In the make_one_year_older method we have used self. What is another way we could write this method so we don't have to use the self prefix?

- answer
First we cannot directly write `age += 1`, because thus Ruby will treat the `age` as a local variable.
To avoid using prefixed `self`, we can preform the increment operation directly on instance variable: `@age += 1`

Question 7

What is used in this class but doesn't add any value?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end
end
```
