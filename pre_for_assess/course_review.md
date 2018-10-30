## Introduction

Two types of programming

- procedural programming
- object oriented programming

## Assignment: OO Book

- Object Oriented Programming, often referred to as OOP, is a programming paradigm that was created to deal with the growing complexity of large software systems.

- Programmers needed a way to create containers for data that could be changed and manipulated without affecting the entire program. They needed a way to section off areas of code that performed certain procedures so that their programs could become the interaction of many small parts, as opposed to one massive blob of dependency.
  - section off
  - modulize
  - interaction

- **Encapsulation** is hiding pieces of functionality and making it unavailable to the rest of the code base. It is **a form of data protection**, so that data cannot be manipulated or changed without obvious intention. It is what defines the boundaries in your application and allows your code to achieve new levels of complexity. Ruby, like many other OO languages, accomplishes this task by creating objects, and **exposing interfaces** (i.e., methods) to interact with those objects.


- Polymorphism is the ability for data to be represented as many different types. "Poly" stands for "many" and "morph" stands for "forms". OOP gives us flexibility in using pre-written code for new purposes.
  - Same set of data can be represented, passed, manipulated or output by different ways, based on how we design(/organize) the structures and relationships of classes(/objects).

- Think of classes as molds and objects as the things you produce out of those molds. Individual objects will contain different information from other objects, yet they are instances of the same class.
  - Class(mold, blueprint, template)
    - instances from same class
      - similarity: share some same attributes and behaviors
      - differences: may hold different information, may have some customized behaviors

- Ruby defines the attributes and behaviors of its objects in classes. You can think of classes as basic outlines of what an object should be made of and what it should be able to do.

- This entire workflow of creating a new object or instance from a class is called instantiation, so we can also say that we've instantiated an object.

-  A module is a collection of behaviors that is useable in other classes via mixins.

- Ruby has a distinct lookup path that it follows each time a method is called.

### Classes and Objects - Part I

-  Instance variables keep track of state, and instance methods expose behavior for objects.

- The initialize method gets called every time you create a new object.

- Instance variable, it is a variable that exists as long as the object instance exists and it is one of the ways we tie data to objects.

- We can see that instance variables are responsible for keeping track of information about the state of an object.

- A NoMethodError means that we called a method that doesn't exist or is unavailable to the object.

### Classes and Objects - Part II

- Class methods are where we put functionality that does not pertain to individual objects. Objects contain state, and if we have a method that does not need to deal with (instances') states, then we can just use a class method.

- Just as instance variables capture information related to specific instances of classes (i.e., objects), we can create variables for an entire class that are appropriately named class variables.

Undefined new instance variables can be referenced in an instance method, the return value is `nil`.

```ruby
class Dog
 def speed
   puts @fast
  end
end
=> :speed
> Dog.new.speed

=> nil
```

But not same with a undefined new class variable:

```ruby
class Dog
  def self.species
    puts @unknown
  end

  def self.fur
    puts @@soft
  end
end
 => :fur
> Dog.species

=> nil
> Dog.fur
Traceback (most recent call last):
        3: from /Users/caven/.rvm/rubies/ruby-2.5.0/bin/irb:11:in `<main>'
        2: from (irb):17
        1: from (irb):13:in `fur'
NameError (uninitialized class variable @@soft in Dog)
2.5.0 :018 >
```

- The to_s instance method comes built in to every class in Ruby.

- The puts method automatically calls `to_s` on its argument. By default, the `to_s` method returns the name of the object's class and an encoding of the object id.
  - `puts 1`, `puts [1,2]`, `puts hash` ...
  - `puts` can be understanded as 'put the string representation(what `to_s` will do) of this object.'

- There's another method called p that's very similar to puts, except it doesn't call to_s on its argument; it calls another built-in Ruby instance method called inspect. The inspect method is very helpful for debugging purposes, so we don't want to override it.
  - `p` method just like 'put the object as it is'
- So this implies that `p sparky` is equivalent to `puts sparky.inspect`.
- Besides being called automatically when using puts, another important attribute of the to_s method is that it's also automatically called in string interpolation.

- In summary, the to_s method is called automatically on the object when we use it with puts or when used with string interpolation. This fact may seem trivial at the moment, but knowing when to_s is called will help us understand how to read and write better OO code.

- From within the class, when an instance method calls `self`, it is returning the calling object.

- You can see that `self`, inside a class but outside an instance method, is actually referring to the class itself.

### Inheritance

- Inheritance is when a class inherits behavior from another class. The class that is inheriting behavior is called the subclass and the class it inherits from is called the superclass.

- `super` allows us to call methods up the inheritance hierarchy. When you call `super` from within a method, it will search the inheritance hierarchy for a method by the same name and then invoke it.

- Extracting common methods to a superclass, like we did in the previous section, is a great way to model concepts that are naturally hierarchical.

- Note: A common naming convention for Ruby is to use the "able" suffix on whatever verb describes the behavior that the module is modeling.

Inheritance vs Mixin

Here are a couple of things to remember when evaluating those two choices.

- You can only subclass from one class. But you can mix in as many modules as you'd like.
- If it's an "is-a" relationship, choose class inheritance. If it's a "has-a" relationship, choose modules. Example: a dog "is an" animal; a dog "has an" ability to swim.
- You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

- The order in which we include modules is important.
  - from down to up
- If the modules we mix in contain a method with the same name, the last module included will be consulted first.

Namespacing with module
- organizing similar classes under a module
  - We call classes in a module by appending the class name to the module name with two colons(::)
- using modules as a container for methods, called module methods, diff from mixin:

```ruby
module Features
  def self.shine
    puts "Shining"
  end
end

Features.shine # notice the usage here.
```

It's not in a class so it's not a class method before it is mixed in another class. And it's not a instance method either. But, we can call it without any class by prepending the name of the module.

Private, Protected, and Public

- A public method is a method that is available to anyone who knows either the class name or the object's name. These methods are readily available for the rest of the program to use and comprise the class's interface (that's how other classes and objects will interact with this class and its objects).

- private methods are only accessible from other methods in the class.

- In summary, private methods are not accessible outside of the class definition at all, and are only accessible from inside the class when called without self.

- from outside the class, protected methods act just like private methods.
- from inside the class, protected methods are accessible just like public methods.

Accidental Method Overriding

- It’s important to remember that every class you create inherently subclasses from class Object. The Object class is built into Ruby and comes with many critical methods.

- A subclass can override a superclass’s method.

- Object `send` serves as a way to call a method by passing it a symbol or a string which represents the method you want to call. The next couple of arguments will represent the method's arguments, if any.

- One `Object` instance method that's easily overridden without any major side-effect is the `to_s` method. You'll normally want to do this when you want a different string representation of an object.

Summary

- While there are definitely wrong ways to design an application, there is often no right choice when it comes to object oriented design, only different tradeoffs.

## Object Oriented Programming

- The method lookup path is the order in which Ruby will traverse the class hierarchy to look for methods to invoke.

- Instance variables can hold any object, not only strings and integers. It can hold data structures, like arrays or hashes.

- Objects that are stored as state within another object are also called "collaborator objects".

- When working with collaborator objects in your class, you may be working with strings, integers, arrays, hashes, or even custom objects. Collaborator objects allow you to chop up and modularize the problem domain into cohesive pieces; they are at the core of OO programming and play an important role in modeling complicated problem domains.

- One of the downsides of inheritance is that a class can only sub-class from one super class. In some situations, this limitation makes it very difficult to accurately model the problem domain.

- One of the hardest things to understand about OOP is that there is no absolute "right" solution. In OOP, it's all a matter of tradeoffs.

- When it comes to object oriented design, we're always juggling a tradeoff between more flexible code and indirection. Put another way, the more flexible your code, the more indirection you'll introduce by way of more classes.

Code tips:
- Explore the problem before design.
  - Take some time to think about conceivable aspects of the problem, ignore code structure, code quality and other details, just play with it first.
  - As you start to understand the problem better and get a feel for possible solutions, start to organize your code into coherent classes and methods.
- Repetitive nouns in method names is a sign that you're missing a class.
  - repetitiveness in **method names**
- When naming methods, don't include the class name.
  - It's not always the case, but most of the time, you can leave off the class name in method definitions. Remember to always think about the method's usage or interface when you define methods. Pick naming conventions that are consistent, easy to remember, give an idea of what the method does, and reads well at invocation time.
- Avoid long method invocation chains.
- Avoid design patterns for now.
  - One of the biggest mistakes beginner programmers make is mis-application of "best practices" or "design patterns" to improve performance or flexibility. This is such a common phenomenon that experienced programmers have a quote: "premature optimization is the root of all evil".
  - Don't worry about optimization at this point. Don't write overly clever code. Granted, you won't know what's considered "clever" vs "normal" without reading a lot of code, but over time, you will start to hone your senses.

Assignment Branch Condition Size - ABC size

You should always examine any complexity complaints that Rubocop issues, and, in most cases, refactor the code to simplify it.
- To derive this metric, Rubocop counts the assignments (call this value a), branches (b), and conditions (c) in your method. It then computes the result using the formula:
```ruby
abc_size = Math.sqrt(a**2 + b**2 + c**2)
```
- If the resulting value is greater than 18 (the default), Rubocop flags the method as too complex. That's all there is to it.

an example:

```ruby
def a_method
  if age < 5
  elsif age > 10
  elsif age % 10 == 0
  end
end
```

it seems nothing can be simplified, but notice every time using `age` counted as a method calling. So:

```ruby
def a_method
  age_value = age
  if age_value < 5
  elsif age_value > 10
  elsif age_value % 10 == 0
  end
end
```

Summary

## More OO Ruby

### Truthiness

- A boolean is an object whose only purpose is to convey whether it is "true" or "false".

Logical operators are comparison operators, and will return either a truthy or falsey value when comparing two expressions.
- `&&``: this operator is the "and" operator and it will return true only if both expressions being compared are true.
- `||`: this operator is the "or" operator and it will return true if either one of the comparison objects is true. It's less strict than the && operator.
- Short Circuiting: the `&&` and `||` operators exhibit a behavior called short circuiting, which means it will stop evaluating expressions **once it can guarantee the return value**.

- Remember this rule: everything in Ruby is considered "truthy" except for false and nil.

### Equivalence

- Suppose we care about whether the two variables actually point to the same object?
  - `equal?`(in the `BasicObject` class)
- `==` is not an operator in Ruby. Since it's an instance method, the answer to "how does == know what value to use for comparison" is: it's determined by the class.
- The original `==` method is defined in the BasicObject class, which is the parent class for all classes in Ruby. This implies every object in Ruby has a `==` method. However, each class should override the `==` method to specify the value to compare.
- You should also realize that `45 == 45.00` is not the same as `45.00 == 45`. The former is calling `Fixnum#==` while the latter is calling `Float#==`. Thankfully, the creator of those methods took time to make the interface consistent.
- When you define a == method, you also get the `!=` for free.

- `===` is used implicitly by the `case` statement.
- The `eql?` method determines if two objects contain the same value and if they're of the same class. This method is used most often by `Hash` to determine equality among its members. It's not used very often.

A madeup example for illustration:

```ruby
num = 25
                            # case num
if (1..50) === num          # when (1..50)
  puts "small number"
elsif (51..100) === num     # when (51..100)
  puts "large number"
else                        # else
  puts "not in range"
end                         # end
```

Always be aware of from where the `===` is being called.

```ruby
> (1..10) === 4
=> true
> 4 === (1..10)
=> false
```

### Variable Scope

- Instance variables are variables that start with `@` and are scoped at the object level. They are used to track individual object state, and do not cross over between objects.
- Unlike local variables, instance variables are accessible within an instance method even if they are not initialized or passed in to the method. Remember, their scope is at the object level.
- If you try to reference an uninitialized local variable, you'd get a NameError. But if you try to reference an uninitialized instance variable, you get `nil`.

Class variables start with `@@` and are scoped at the class level. They exhibit two main behaviors:

- all objects share 1 copy of the class variable. (This also implies objects can access class variables by way of instance methods.)
- class methods can access class variables, regardless of where it's initialized.

- Constants begin with a capital letter and have lexical scope.

### Inheritance and Variable Scope

- For some odd reason, the class variable in the subclass affected the class variable in the super class.

- A constant initialized in separate classes is not shared, we have to call it with explictly prepended namespacing.
- A constant initialized in a super-class is inherited by the sub-class, and can be accessed by both class and instance methods.
- When calling a constant within a mixed in method, we must give the usable namespacing too.
  - prepend a subclass' name which inherits from where the constant is initialized.
  - prepend the class' name which first initialized the constant.

### Exceptions

You may always choose to be more specific about which type of exception to handle, but remember to never rescue the `Exception` class.

## Small Problems

- To pass specific arguments with #super, we need to list the arguments within parentheses
- We can invoke #super with empty parentheses, which means no arguments will be passed.
- Modules are useful for containing similar methods, however, sometimes class inheritance is also needed. This exercise illustrates that it's possible to inherit from both a module and a class at the same time.
  - to some extent, mixin can be seen as a form of inheritance
  - it's like 'non-biological' inheritance
- Nearly every class in Ruby inherits from another class. This is true until the class named `BasicObject`, which doesn't inherit from a class. Some classes also include modules, much as the `Object` class includes the `Kernel` module.
-  When a module is included in a class, the class is searched before the module. But, the module is searched before the superclass. This order of precedence applies to all modules and classes in the inheritance hierarchy.
- Modules are not only useful for grouping common methods together, but they're also useful for namespacing. Namespacing is where similar classes are grouped within a module. This makes it easier to recognize the purpose of the contained classes. Grouping classes in a module can also help avoid collision with classes of the same name.
- When a method is private, only the class - not instances of the class - can access it. However, when a method is protected, only instances of the class or a subclass can call the method. This means we can easily share sensitive data between instances of the same class type.
-  We say that calling the setter method, if available, is safer since using the instance variable bypasses any checks or operations performed by the setter.
- There is one other "form" of the keyword super. We can call it as super(). This calls the superclass method of the same name as the calling method, but here no arguments are passed to the superclass method at all.
- `Exception` is the top-most class in Ruby's exception hierarchy and it seems a straightforward choice to rescue or inherit from. But it's too broad. When creating custom exceptions and when rescuing exceptions, it's good practice to always use the subclass `StandardError`. `StandardError` subsumes all application-level errors. The other descendants of `Exception` are used for system- or environment-level errors, like memory overflows or program interruptions. These are the kind of errors your application usually does not want to throw - and definitely does not want to rescue, they should be handled by Ruby itself.
- In Ruby, setter methods **always** return the argument that was passed in, even when you add an explicit return statement. 
