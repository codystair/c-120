module Talkable
  class Body
    WEIGHT = 10

    def report_weight
      puts "#{self.class}'s weight is #{rand(self.class::WEIGHT)}."
    end
  end
end
# ------------------------------------------------------------------------------


# Body.new.report_weight # how to fix this

# Talkable::Body.new.report_weight

# it's about namespacing
