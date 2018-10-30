From Object Oriented Programming with Ruby book is:

> Polymorphism is the ability for data to be represented as many different types. "Poly" stands for "many" and "morph" stands for "forms". OOP gives us flexibility in using pre-written code for new purposes.

Discussions in LS:
https://launchschool.com/posts/ab225b48
https://launchschool.com/posts/4fa19769

An article from thoughtbot
https://robots.thoughtbot.com/back-to-basics-polymorphism-and-ruby

> At its core, in Ruby, it means being able to send the same message to different objects and get different results.

"send the same message to different objects"
  - call same name method on different objects
    - `to_s` method for different Ruby classes
    ```ruby
    > (1..10).to_s
    => "1..10"
    > (1..10).to_a.to_s
    => "[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]"
    > 1.to_s
    => "1"
    > {1 => "a", 2 => "b"}.to_s
    => "{1=>\"a\", 2=>\"b\"}"
    ```
    - `size` method for different Ruby classes
    ```ruby
    > File.new("testfile").size  # Returns the size of file in bytes.
    => 66
    > hash.size # Returns the number of key-value pairs in the hash.
    => 5
    > integer.size # Returns the number of bytes in the machine representation of int (machine dependent).
    > 1.size
    => 8
    > 9.size
    => 8
    > string.size # Returns the character length of str.
    > 'hello world'.size
    => 11
    > array.size  # Returns the number of elements in self. May be zero.
    > [].size
    => 0
    ```

So put it(polymorphsim) another way, is while keeping the consistency of interface, or say, sending the same message to different types(classes) of object, we can get different response(result/return value). It's a typical character(feature) of OOP. And Ruby's way to implement this feature is by:

- inheritance
- minxin
- duck typing
- decorator pattern(I don't know what the last two is now)

In a word, 2 things here should be differentiated
1. polymorphism is a feature(of object-oriented programming)
2. there are ways to achieve this feature(inheritance, mixin ...)

The first is a feature, the second is ways.
