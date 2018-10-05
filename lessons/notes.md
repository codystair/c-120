Objects that are stored as state within another object are also called "collaborator objects".

When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.

Don't worry about finding the most optimal architecture or design. Object oriented design and architecture is a huge topic in itself, and it's going to take years (maybe decades!) to master that.

Remember to always think about the method's usage or interface when you define methods. Pick naming conventions that are consistent, easy to remember, give an idea of what the method does, and reads well at invocation time.

The AbcSize COP is a code complexity warning that counts the assignments, branches (aka, method calls), and conditions in a method, then reduces those numbers to a single value - a metric - that describes the complexity.

Short Circuiting: the && and || operators exhibit a behavior called short circuiting, which means it will stop evaluating expressions once it can guarantee the return value.

Note that an expression that Ruby considers true is not the same as the true object. This is what "truthiness" means.

everything in Ruby is considered "truthy" except for false and nil.

because || didn't evaluate the second expression; it short circuited after encountering true.

In summary, the == method compares the two variables' values whereas the equal? method determines whether the two variables point to the same object.

The original == method is defined in the BasicObject class, which is the parent class for all classes in Ruby. This implies every object in Ruby has a == method. However, each class should override the == method to specify the value to compare.

when you define a == method, you also get the != for free.

When === compares two objects, such as (1..50) and 25, it's essentially asking "if (1..50) is a group, would 25 belong in that group?"

### variable scope

Instance variables are variables that start with @ and are scoped at the object level. They are used to track individual object state, and do not cross over between objects.

Unlike local variables, instance variables are accessible within an instance method even if they are not initialized or passed in to the method. Remember, their scope is at the object level.

If you try to reference an uninitialized local variable, you'd get a NameError. But if you try to reference an uninitialized instance variable, you get nil.

Class variables start with @@ and are scoped at the class level. They exhibit two main behaviors:

- all objects share 1 copy of the class variable. (This also implies objects can access class variables by way of instance methods.)
- class methods can access class variables, regardless of where it's initialized.

For some odd reason, the class variable in the sub-class affected the class variable in the super class. Worse still, this change will affect all other sub-classes of Vehicle!

For this reason, avoid using class variables when working with inheritance. In fact, some Rubyists would go as far as recommending avoiding class variables altogether. The solution is usually to use class instance variables.

Be mindful that constant resolution rules are different from method lookup path or instance variables.

- Instance Variables behave the way we'd expect. The only thing to watch out for is to make sure the instance variable is initialized before referencing it.
- Class Variables have a very insidious behavior of allowing sub-classes to override super-class class variables. Further, the change will affect all other sub-classes of the super-class. This is extremely unintuitive behavior, forcing some Rubyists to eschew using class variables altogether.
- Constants have lexical scope which makes their scope resolution rules very unique compared to other variable types. If Ruby doesn't find the constant using lexical scope, it'll then look at the inheritance hierarchy.

Handling all exceptions may result in masking critical errors and can make debugging a very difficult task.

Using a begin/rescue block to handle errors can keep your program from crashing if the exception you have specified is raised.

 If no exception is raised, the rescue clause will not be executed at all and the program will continue to run normally.

 If no exception type is specified, all StandardError exceptions will be rescued and handled. Remember not to tell Ruby to rescue Exception class exceptions. Doing so will rescue all exceptions down the Exception class hierarchy and is very dangerous, as explained previously.

 retry must be called within the rescue block
