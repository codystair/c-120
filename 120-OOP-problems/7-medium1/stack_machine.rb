# Methods that will touch the stack
  # push, add, sub, mult, div, mod, pop
# Methods that will not touch the stack
  # n, print
class Minilang
  attr_accessor :register
  attr_reader :stack, :commands

  METHODS = {
    'PUSH' => :push,
    'ADD' => :+,
    'SUB' => :-,
    'MULT' => :*,
    'DIV' => :/,
    'MOD' => :%,
    'POP' => :pop
  }

  def initialize(commands)
    @register = 0
    @stack = []
    @commands = commands
  end

  def eval
    commands.split.each { |obj| meet(obj) }
  end

  private

  def meet(obj)
    if obj.to_i.to_s == obj # it's a integer
      self.register = obj.to_i
    else
      perform(obj)
    end
  end

  def perform(method)
    if method == 'POP' then self.register = stack.pop
    elsif method == 'PRINT' then mini_print
    elsif method == 'PUSH' then stack << register
    elsif METHODS.keys.include?(method)
      self.register = stack.pop.send(METHODS[method], register)
    else
      puts "Invalid token: #{method}"
    end
  end

  def mini_print
    register ? puts(register) : puts('Empty stack!')
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
