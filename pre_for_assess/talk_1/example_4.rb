module Talkable
  def report_weight
    puts "#{self.class}'s weight is #{rand(self.class::WEIGHT)}."
  end
end
# ------------------------------------------------------------------------------
class Body
  include Talkable
  WEIGHT = 10

  def report_weight
    puts "#{self.class}'s weight is #{WEIGHT}."
  end
end

Body.new.report_weight

# it's about lookup path
