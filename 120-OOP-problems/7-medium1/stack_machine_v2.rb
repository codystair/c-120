require 'pry'
class Minilang
  attr_accessor :register, :commands
  attr_reader :stack

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

  def eval(hsh=nil)
    begin
      formatted_commands = format_commands(hsh)
      formatted_commands.split.each { |obj| meet(obj) }
    rescue NoMethodError, SystemStackError => error
      puts error.message
    end
  end

  def format_commands(hsh)
    if hsh
      format(commands, hsh)
    else
      commands
    end
  end

  private

  def meet(obj)
    if obj.to_i.to_s == obj
      self.register = obj.to_i
    else
      perform(obj)
    end
  end

  def perform(method)
    if method == 'POP' then mini_pop
    elsif method == 'PRINT' then mini_print
    elsif method == 'PUSH' then stack << register
    elsif METHODS.keys.include?(method)
      self.register = register.send(METHODS[method], stack.pop)
    else
      raise NoMethodError, "Invalid token: #{method}"
    end
  end

  def mini_print
    register ? puts(register) : puts('Empty stack!')
  end

  def mini_pop
    if stack.empty?
      raise SystemStackError, "Empty stack!"
    else
      self.register = stack.pop
    end
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

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang.eval(degrees_c: 100)
# 212
minilang.eval(degrees_c: 0)
# 32
minilang.eval(degrees_c: -40)
# -40
