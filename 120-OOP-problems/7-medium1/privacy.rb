
class Machine
  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  private
  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
    # self.shout
    puts self.switch = "changed"
  end

  # def shout
  #   puts "#{self.class} shouted Wow!"
  # end
end

machine = Machine.new
machine.start
p machine
