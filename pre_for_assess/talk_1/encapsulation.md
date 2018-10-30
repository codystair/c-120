example from Eric

```Ruby
class User
  def initialize(first, last)
    @first_name = first
    @last_name = last
  end

   def name
     "#{first_name} #{last_name}".split.map(&:capitalize).join(' ')
   end

   private
   attr :first_name, :last_name
end

puts User.new("elmer", "fudd").name
```
