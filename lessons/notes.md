Objects that are stored as state within another object are also called "collaborator objects".

When working on an object oriented program be sure to consider what collaborators your classes will have and if those associations make sense, both from a technical standpoint and in terms of modeling the problem your program aims to solve.

Don't worry about finding the most optimal architecture or design. Object oriented design and architecture is a huge topic in itself, and it's going to take years (maybe decades!) to master that.

Remember to always think about the method's usage or interface when you define methods. Pick naming conventions that are consistent, easy to remember, give an idea of what the method does, and reads well at invocation time.

The AbcSize COP is a code complexity warning that counts the assignments, branches (aka, method calls), and conditions in a method, then reduces those numbers to a single value - a metric - that describes the complexity. 
