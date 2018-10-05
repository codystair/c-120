## Practice Problems: Medium 1

Question 1

Ben asked Alyssa to code review the following code:
```ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```

Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the @ before balance when you refer to the balance instance variable in the body of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

Who is right, Ben or Alyssa, and why?

- answer
Ben is right. Because Ben has written `attr_reader :balance`, so inside instance method definition, it can use `balance` to read the corresponding attribute value directly if the code expression has no ambiguity.

Question 2

Alyssa created the following code to keep track of items for a shopping cart application she's writing:
```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

Alan looked at the code and spotted a mistake. "This will fail when update_quantity is called", he says.

Can you spot the mistake and how to address it?

- answer

1 In this case, the code expression `quantity = ...` has ambiguity, Ruby will treat `quantity` as a new local variable, not the attribute of instance. To avoid this, when we are updating the value of a specific attribute, we shoud prepend a `self` to eliminate the ambiguity:
`self.quantity = updated_count if updated_count >= 0`
2 For `:quantity` attribute, Alyssa only wrote getter method for it, we should add a setter method to this attribute. If she don't wanna add setter method, she could change the code to
`@quantity = updated_count if updated_count >= 0`

Question 3

In the last question Alyssa showed Alan this code which keeps track of items for a shopping cart application:
```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
```

Alan noticed that this will fail when update_quantity is called. Since quantity is an instance variable, it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader to attr_accessor and change quantity to self.quantity.

Is there anything wrong with fixing it this way?

- By writing `attr_accessor :quantity` we expose the interface `quantity = `, so there is potential danger that user might change the quantity directly without go through the check step set in `update_quantity` method.

Question 4

Let's practice creating an object hierarchy.

Create a class called Greeting with a single method called greet that takes a string argument and prints that argument to the terminal.

Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye. The Hello class should have a hi method that takes no arguments and prints "Hello". The Goodbye class should have a bye method to say "Goodbye". Make use of the Greeting class greet method when implementing the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.

- answer

```ruby
class Greeting
  def greet(string)
    puts string
  end
end

class Hello < Greeting
  def hi
    greet "Hello."
  end
end

class Goodbye < Greeting
  def bye
    greet "Goodbye."
  end
end
```

Question 5

You are given the following class that has been implemented:
```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    filling_type ? @filling_type = filling_type : @filling_type = "Plain"
    @glazing = glazing
  end

  # added code below
  def to_s
    if @glazing
      "#{@filling_type} with #{@glazing}"
    else
      @filling_type
    end
  end
end
```
And the following specification of expected behavior:
```ruby
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"
# there exsits some default attribute value
# the `to_s` method in this class has been rewrite

puts donut2
  => "Vanilla"
# if second argument is nil, it will print out the filling_type value

puts donut3
  => "Plain with sugar"
# if the passing in filling_type argument is nil, the filling_type will defaultly set to "Plain"

puts donut4
  => "Plain with chocolate sprinkles"
# if the passing in filling_type is nil, then @filling_type will set to "Plain"
# if the passing glazing is nil, it just set it to nil

puts donut5
  => "Custard with icing"
# the rewritten `to_s` is
  # if glazing => "#{filling_type} with #{glazing}"
  # else filling_type

```
Write additional code for KrispyKreme such that the puts statements will work as specified above.

Question 6

If we have these two methods:
```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
```
and
```ruby
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
```
What is the difference in the way the code works?

- answer
1 In the first case's create template, we are setting the value of `:template` attribute by reference the instance variable `@template` directly; but the the second case's create_template method, we are setting the value by using `self.template`, this utilize the setting method we added, which is not being used in the first case's `create_template` method.
2 In the first case's `show_template` method, we write `template` directly, here we omit the prepending `self.`, because in thei context, calling `template` has no ambiguity, so Ruby will know we wanna retrieve the value of the attribute. In the second case, we write a full version of code by using `self.template`

Question 7

How could you change the method name below so that the method name is more clear and less repetitive.

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
end
```
