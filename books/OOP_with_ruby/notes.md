## The Object Model

**Polymorphism** is the ability for data to be represented as many different types.

核心指某个对象因某些原因或目的能在不同时间和空间中呈现出不同的形态，但其本质部分仍在。

In dictionary:
- [mass noun]the occurrence of something in several different forms, in particular
多形现象，尤指
- ■(Biology)the occurrence of different forms among the members of a population or colony, or in the life cycle of an individual organism
(生)多形性
- ■(Genetics)the presence of genetic variation within a population, upon which natural selection can operate
(遗传)（基因）多态性
- ■(Computing)a feature of a programming language that allows routines to use variables of different types at different times
(计算机)多变量性

### What Are Objects?


Objects are created from classes，instantiated from a class

We create an object by defining a class and instantiating it by using the `.new` method to create an instance, also known as an object.

-

Ruby defines the attributes and behaviors of its objects in classes.

### Classes Define Objects

This entire workflow of creating a new object or instance from a class is called instantiation

### Modules

A module is "mixed in" to a class using the include method invocation.

A module allows us to group reusable code into one place. We use modules in our classes by using the include reserved word, followed by the module name. Modules are also used as a namespace.

### Method Lookup

We can use the ancestors method on any class to find out the method lookup chain.

-

## Classes and Objects - Part I

### States and Behaviors

When defining a class, we typically focus on two things: states and behaviors.

States track attributes for individual objects. Behaviors are what objects are capable of doing.

be 动词和 情态动词（can could must may might should）

instance variables are scoped at the object (or instance) level, and are how objects keep track of their states.

instance variables keep track of state, and instance methods expose behavior for objects.

### Initializing a New Object

The initialize method gets called every time you create a new object.

We refer to the initialize method as a constructor, because it gets triggered whenever we create a new object.

### Instance Variables

instance variable exists as long as the object instance exists and it is **one of** the ways we tie data to objects.

### Instance Methods

all objects of the same class have the same behaviors, though they contain different states

### Accessor Methods

## Classes and Objects - Part II

### Class Methods

Class methods are methods we can call directly on the class itself, without having to instantiate any objects.

Objects contain state, and if we have a method that does not need to deal with states, then we can just use a class method

### Class Variables

we can access class variables from within an instance method

### Constant

### The to_s Method

By default, the to_s method returns the name of the object's class and an encoding of the object id.

So this implies that p sparky is equivalent to puts sparky.inspect.

another important attribute of the to_s method is that it's also automatically called in string interpolation.

In summary, the to_s method is called automatically on the object when we use it with puts or when used with string interpolation. This fact may seem trivial at the moment, but knowing when to_s is called will help us understand how to read and write better OO code.

### More About self

## Inheritance

### Class Inheritance

keep logic in one place

Inheritance can be a great way to remove duplication in your code base.

### super

When you call super from within a method, it will search the inheritance hierarchy for a method by the same name and then invoke it.

### Mixing in Modules

Note: A common naming convention for Ruby is to use the "able" suffix on whatever verb describes the behavior that the module is modeling. You can see this convention with our Swimmable module. Likewise, we could name a module that describes "walking" as Walkable. Not all modules are named in this manner, however, it is quite common.

### Inheritance vs Modules

- You can only subclass from one class. But you can mix in as many modules as you'd like.
- If it's an "is-a" relationship, choose class inheritance. If it's a "has-a" relationship, choose modules. Example: a dog "is an" animal; a dog "has an" ability to swim.
- You cannot instantiate modules (i.e., no object can be created from a module). Modules are used only for namespacing and grouping common methods together.

### Method Lookup Path

Ruby actually looks at the last module we included first.

the module included in the superclass made it on to the method lookup path


### More Modules

namespacing means organizing similar classes under a module

### Private, Protected, and Public

A public method is a method that is available to anyone who knows either the class name or the object's name.

private methods are only accessible from other methods in the class

In summary, private methods are not accessible outside of the class definition at all, and are only accessible from inside the class when called without self.

The easiest way to understand protected methods is to follow these two rules:
- from outside the class, protected methods act just like private methods.
- from inside the class, protected methods are accessible just like public methods.

```ruby
class Animal
  def a_public_method
    "Will this work?" + self.a_protected_method
  end

  protected

  def a_protected_method
    "I am protected!"
  end
end

fido = Animal.new
p fido.a_public_method
p fido.a_protected_method
```

### Accidental Method Overriding

a subclass can override a superclass’s method.

one Object instance method that's easily overridden without any major side-effect is the to_s method. You'll normally want to do this when you want a different string representation of an object.

### Summary

While there are definitely wrong ways to design an application, there is often no right choice when it comes to object oriented design, only different tradeoffs. 
