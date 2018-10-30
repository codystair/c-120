module Talkable
  WEIGHT = 10

  def self.report_weight
    puts "#{self.class}'s weight is #{WEIGHT}."
  end
end
# ------

# how to call report_weight here and what the expected output
# 
# Talkable.report_weight
