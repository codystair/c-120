## Practice Problems: Easy 2

Question 1

You are given the following code:
```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```
What is the result of calling
```ruby
oracle = Oracle.new
oracle.predict_the_future
```

- answer
The return value is a string which contains `"You will "` and one of the string contained in `["eat a nice lunch", "take a nap soon", "stay at work late"]`

Question 2

We have an Oracle class and a RoadTrip class that inherits from the Oracle class.

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```
What is the result of the following:
```ruby
trip = RoadTrip.new
trip.predict_the_future
```

- answer
The return value is a string which contains `"You will "` and one of the string contained in `["visit Vegas", "fly to Fiji", "romp in Rome"]`
In this case when we call `predict_the_future` on the RoadTrip object, at first it cannot find this method in current class, so it will go up the inheritance chain, and it will find the required method in Oracle class. Then the code in `predict_the_future` will be executed, which is:
`"You will " + choices.sample`
this will invoke `choices` method on the RoadTrip object, actually, here we omit a `self` before the `choices.sample`, the complete expresssion is `self.choices.sample`, here since the `self` is referencing to a RoadTrip object, so it will starting to look for the method from RoadTrip, and there does have a choices method in this class. So the return value of the `choices` inside RoadTrip is `["visit Vegas", "fly to Fiji", "romp in Rome"]`, and this return value will serves as the caller of the `sample` method, this is why `trip.predict_the_future` will invoke the `choices` in itself's class, not the upstream one.


Question 3

How do you find where Ruby will look for a method when that method is called? How can you find an object's ancestors?

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

- answer
No matter what method we are calling, there is always a implied `self`, which pointing the receiver of the method call. So first we need to know what object the `self` represents when we call a method. If `self` is an instance of some class, it would first looking for the method in its class, and if there is not, it will continue looking for it upwards to the modules being included, and if there still not, it will go up the inheritance chain.

`object.class.ancestors`

What is the lookup chain for Orange and HotSauce?

- answer
Orange: Orange < Taste
HotSauce: HotSauce < Taste

Question 4

What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

- answer
Integrate the getter/setter methods into on line: `attr_accessor :type`


Question 5

There are a number of variables listed below. What are the different types and how do you know which is which?

```ruby
excited_dog = "excited dog" # local variable
@excited_dog = "excited dog" # instance variable
@@excited_dog = "excited dog" # class variable
```

This is how Ruby representing different types of vairables.

Question 6

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

Which one of these is a class method (if any) and how do you know? How would you call a class method?

- answer
In a class definition, if we defining a method use `self.method_name` on the name a method, we were defining a class method. The key point here is to recognize what `self` mean in current context.
Calling a class method, just call the method on class itself, not its instance.

Question 7

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
Explain what the @@cats_count variable does and how it works. What code would you need to write to test your theory?

- answer
First we initialize this class variable `@@cats_count` and set it to 0
Then we increment it by one every time we create a new Cat instance.
Finally we wrote a class method `Cat::cats_count` to read the value of the class variable.

We can verify this by:
```ruby
5.times { Cat.new("cute") }
puts Cat.cats_count # should print out `5`
2.times { Cat.new("smelly") }
puts Cat.cats_count # should print out `7`
```

Question 8

If we have this class:
```ruby
class Game
  def play
    "Start the game!"
  end
end
```
And another class:
```ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```
What can we add to the Bingo class to allow it to inherit the play method from the Game class?

`Bingo < Game`

Question 9

If we have this class:
```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

What would happen if we added a play method to the Bingo class, keeping in mind that there is already a method of this name in the Game class that the Bingo class inherits from.

- answer

It will prior to the `play` in Game, since the same name method is in itself's class, or say, the latter `play` is at the downstream of the method lookup path.

Question 10

What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

answer

- Comparing to procedural program
 - OOP's concept of object is more close to how humaning thinking about the real world
 - the use of different types of variables simplifise the use of a big number of local variables in procedural program.
 - The existence of class, module, and the rule of inheritance or method lookup path makes the responsibility for every method more clear, and also adds much flexibility to the accessiblity of methods.
 - Iheritance allows us to build different constructures on different level, including a very small piece of code, or a big program.
 - procedural programming has loosely limit on how to program, this actually make more difficulties for novices, however OOP comes more regularized and has some clear boundaries, this made it easier for novices to learn from ground.

 There are some advantages I felt. But there's more on technic level.

standard answer
Because there are so many benefits to using OOP we will just summarize some of the major ones:

- Creating objects allows programmers to think more abstractly about the code they are writing.
- Objects are represented by nouns so are easier to conceptualize.
- It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
- It allows us to easily give functionality to different parts of an application without duplication.
- We can build applications faster as we can reuse pre-written code.
- As the software becomes more complex this complexity can be more easily managed.
