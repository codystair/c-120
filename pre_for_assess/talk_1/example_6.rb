def print_self
  puts self
end

print_self

module Talkable
  print_self

  def report_self
    print_self
  end

  def self.report_self
    print_self
  end

  class Body
    print_self
    include Talkable
    WEIGHT = 10
  end
end
# ------------------------------------------------------------------------------
Talkable::Body.new.report_self # don't forget this one

# it's about self
