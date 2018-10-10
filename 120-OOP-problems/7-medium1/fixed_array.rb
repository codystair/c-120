class FixedArray
  attr_reader :body, :size

  def initialize(size)
    @size = size
    #@body = [nil] * size
    @body = Array.new(size)
  end

  def [](index)
    # if [(0..(size-1)), (-size..-1)].any? { |valid_idxes| valid_idxes.include?(index) }
    #   body[index]
    # else
    #   raise IndexError, "index #{index} is out of range(#{size - 1})."
    # end
     body.fetch(index)
  end

  def []=(index, element)
    body[index] = element
  end

  def to_a
    body.clone.to_a
  end

  def to_s
    to_a.to_s
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end
