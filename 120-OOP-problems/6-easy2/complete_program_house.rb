class House
  include Comparable
  attr_reader :price

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
    # if self.price > other.price
    #   1
    # elsif self.price < other.price
    #   -1
    # else
    #   0
    # end
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1
#
# and this output:
#
# Home 1 is cheaper
# Home 2 is more expensive
