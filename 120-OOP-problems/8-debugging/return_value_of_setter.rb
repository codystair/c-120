class What
  def name=(name)
    return "Returned at the very beginning."
    name.downcase!
    @name = name
  end
end

person = What.new
p person.name = 'BOB' # => 'BOB'
