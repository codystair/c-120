module Talkable
  def report_weight
    puts "#{self.class}'s weight is #{self.class::WEIGHT}."
  end
end
# ------------------------------------------------------------------------------
class Body
  include Talkable
  WEIGHT = 10
end
# ------------------------------------------------------------------------------
class Brain < Body
  WEIGHT = 1
end
# ------------------------------------------------------------------------------
class Cortex < Brain
  WEIGHT = 0.5
end
# ------------------------------------------------------------------------------
Body.new.report_weight
Brain.new.report_weight
Cortex.new.report_weight
