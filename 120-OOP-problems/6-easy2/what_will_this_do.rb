class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new # create a new Something object which contains @data='Hello'
puts Something.dupdata # => ByeBye
puts thing.dupdata # => HelloHello
