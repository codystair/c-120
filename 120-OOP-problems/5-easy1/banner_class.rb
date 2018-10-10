require 'pry'
class Banner
  def initialize(message, extra_width = 4)
    width = message.length + extra_width
    if width > 80
      puts "Extra width too big(#{extra_width}), should be less than: #{80 - message.length}"
      exit
    else
      @message = message
      @width = width
    end
  end

  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end

  private

  def horizontal_rule
    "+#{'-' * (@width - 2)}+"
  end

  def empty_line
    "|#{' ' * (@width - 2)}|"
  end

  def message_line
    '|' + @message.center(@width - 2) + '|'
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 38)
puts banner

# banner = Banner.new('')
# puts banner
