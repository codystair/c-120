# set a smallest width 10
# set a greatest width 80
  # all the given width in between these two limits should appropriately formatted
# how to handle the scenario that use gives out of limits width
  # print out a hint
  # exit the whole program
# how to handle the message that is too long for the given width within one line?
  # split message in multiple lines
    # ensure every line possesses same width
      # => maximum width - 4 (the 4 is for dilimiter and 2 extra space at the left and right edge)
  # printout the multiple lines
  # @lines = [lines here/n]
    # iterating every line and print it out
class Banner
  attr_reader :message, :fixed_width, :min_available_width
  MAX_WIDTH = 80

  def initialize(message, fixed_width = MAX_WIDTH)
    @message = message
    @min_available_width = calculate_min_available_width
    if valid_width?(fixed_width)
      @fixed_width = fixed_width
    else
      report_available_width
      exit
    end
  end

  def to_s
    [horizontal_rule, empty_line, lines_with_content, empty_line, horizontal_rule].join("\n")
  end

  private

  def calculate_min_available_width
    message.split.max_by {|word| word.length }.length + 4
  end

  def valid_width?(width)
    (min_available_width..MAX_WIDTH).include?(width)
  end

  def report_available_width
    puts "The available width should between #{min_available_width} and #{MAX_WIDTH}."
  end

  def extract_line!(words, line_width)
    single_line = []
    loop do
      current_width = single_line.join(' ').length
      next_width = current_width + words.first.to_s.length
      break if words.empty? || next_width > line_width
      single_line << words.shift
    end
    single_line.join(' ')
  end

  def lines_with_content
    line_width = fixed_width - 4
    words = message.split(' ')
    splited_messages = []
    while words != []
      splited_messages << extract_line!(words, line_width)
    end
    splited_messages.map { |m| '|' + m.center(fixed_width - 2) + '|'}
  end

  def horizontal_rule
    "+#{'-' * (@fixed_width - 2)}+"
  end

  def empty_line
    "|#{' ' * (@fixed_width - 2)}|"
  end

end

string = "The smaller the app, the faster it loads. Here's how I reduced the size of a favorite WebVR game, optimizing font, audio, and image files to hit my target: 10-second load times in VR headsets."

banner = Banner.new(string, 14)
puts banner

banner = Banner.new(string)
puts banner

banner = Banner.new(string, 13)
