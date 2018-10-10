class Book
  attr_accessor :title, :author

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

# Expected output:
#
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

# Further Exploration

# If we assign the attributes separately after we initializing a new instance
  # We have to write the setter methods, by doing this
    # we need to write extra code
    # we expose the interface of changing instances
      # so we may need to consider the security guard
    
