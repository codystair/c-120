Objects that are stored as state within another object are also called "collaborator objects".

When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.

Don't worry about finding the most optimal architecture or design. Object oriented design and architecture is a huge topic in itself, and it's going to take years (maybe decades!) to master that.

Remember to always think about the method's usage or interface when you define methods. Pick naming conventions that are consistent, easy to remember, give an idea of what the method does, and reads well at invocation time.

The AbcSize COP is a code complexity warning that counts the assignments, branches (aka, method calls), and conditions in a method, then reduces those numbers to a single value - a metric - that describes the complexity.

Short Circuiting: the && and || operators exhibit a behavior called short circuiting, which means it will stop evaluating expressions once it can guarantee the return value.

Note that an expression that Ruby considers true is not the same as the true object. This is what "truthiness" means.

everything in Ruby is considered "truthy" except for false and nil.

because || didn't evaluate the second expression; it short circuited after encountering true.

### Program Operation/ Gameplay
- improved validation cycle with `ask_name`
- accepts abbreviated input
- clear screen after finishing a round
- user can choose to play again or exit after finishing a set
- at the beginning of every new set, computer's personality will be reset
### Rubocop
As you said, rubocop complains about the use of class variable. I considered constant at first, but it needs to dynamically change winning score, so I chose class variable. You mentioned I should be careful if there existed inheritance relationship on class that contains class variable, I'll then notice that.

Another complaint about '%w-literals', if I change it to `%w[]` for array of strings, I got:
```ruby
10_rps_v1.rb:108:11: C: %w-literals should be delimited by ( and ).
```
So I think maybe it's the `.yml` file is too old in my computer, and I do think using `%[]` makes more sense for array.
### Source Code
- I rearranged `class RPSGame`, tried to make methods name more consistent and meaningful
- delete redundant method for setting user's name
- integrate `MOVES` and `WINS` into a hash `MOVES_AND_WINS`, this does a greate simplification on my code
- corrected typos
