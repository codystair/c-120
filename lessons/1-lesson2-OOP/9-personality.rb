# top class
require 'pry'
class Player
  attr_accessor :choice, :name, :score, :choices

  def initialize
    set_name
    @score = 0
    @choices = []
  end
end
# ----------------------------------------------------------------------
class Human < Player
  def set_name
    self.name = ask_name
  end

  def ask_name
    puts 'Set your name: '
    answer = gets.chomp
    if answer.squeeze == ' '
      puts 'Name can not be set to empty!'
      ask_name
    else
      self.name = answer.capitalize
    end
  end

  def choose
    choice = nil
    loop do
      puts "Please choose from (#{Choice::MOVES.join(", ")}): "
      choice = gets.chomp
      break if Choice::MOVES.include?(choice)
      puts 'Sorry, invalid choice!'
    end
    chosed = Choice.new(choice)
    self.choice = chosed
    self.choices << chosed.value
  end
end
# ----------------------------------------------------------------------
class Computer < Player
  attr_accessor :weights, :personality

  def initialize
    @personality = Personality.new
    super
    @weights = {}
    Choice::MOVES.each do |choice|
      @weights[choice] = 20
    end
  end

  def set_name
    self.name = personality.type + " " + ('a'..'z').to_a.sample(4).join.upcase
  end

  def reallocate_weights(last_result)
    case last_result
    when "lost"
      @weights[choices.last] -= 10
    when "won"
      @weights[choices.last] += 10
    end
    retouch_weights
  end

  def retouch_weights
    case self.personality.type
    when 'lazy'
      weights[self.personality.preference] *= 1.2
    when 'rocky'
      weights['rock'] *= 1.2
    when 'stubborn'
      weights.each { |k, v| weights[k] = 0 unless k == self.personality.preference }
    when 'casual'
      weights.each { |k, v| weights[k] = rand(100) }
    end
  end

  def weightest_choice
    self.weights.max_by { |_, v| v }[0]
  end

  def choose
    #reallocate_weights(last_result)
    chosed = Choice.new(weightest_choice)
    self.choice = chosed
    self.choices << chosed.value
  end
end

class Personality
  attr_accessor :type, :preference
  TYPES = %w(rocky stubborn casual lazy)

  def initialize
    @type = TYPES.sample
    if @type == "lazy" || @type == "stubborn"
      @preference = Choice::MOVES.sample
    elsif @type == 'rocky'
      @preference = 'rock'
    end
  end
  # lazy: choose one option and continuely allocate more weight to this choice
  # rocky: will allocate more weight to rock, always
  # stubborn: every round it just sticks to one choice
  # casual: randomly chooses
end
# ----------------------------------------------------------------------

class Choice
  include Comparable
  MOVES = %w(rock paper scissors lizard spock).freeze
  WINS = [
    %w(paper rock),
    %w(paper spock),
    %w(rock scissors),
    %w(rock lizard),
    %w(scissors lizard),
    %w(scissors paper),
    %w(lizard spock),
    %w(lizard paper),
    %w(spock rock),
    %w(spock scissors)
  ].freeze
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def <=>(other)
    c1, c2 = self.value, other.value
    if WINS.include?([c1, c2])
      1
    elsif c1 == c2
      0
    else
      -1
    end
  end

  def to_s
    @value
  end
end
# player has move
  # when? when they trigger the choose method
# ----------------------------------------------------------------------
class RPSGame
  attr_accessor :human, :computer, :history

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_goodbye_message
    puts 'Thanks for playing this game. Goodbye!'
  end

  def verdict(human, computer)
    if human.choice == computer.choice
      computer.reallocate_weights("tie")
      puts 'It\'s a Tie in this round!!!'
      puts "#{human.name}(#{human.score}) VS #{computer.name}(#{computer.score})"
    elsif human.choice > computer.choice
      human.score += 1
      computer.reallocate_weights("lost")
      puts 'You Won in this round!!!'
      puts "#{human.name}(#{human.score}) VS #{computer.name}(#{computer.score})"
    else
      computer.score += 1
      computer.reallocate_weights("won")
      puts 'You Lost in this round!!!'
      puts "#{human.name}(#{human.score}) VS #{computer.name}(#{computer.score})"
    end
  end

  def display_winner
    puts "#{human.name} chose #{human.choice}"
    puts "#{computer.name} chose #{computer.choice}"
    verdict(human, computer)
  end

  def display_welcome_message
    puts 'Welcome to Rock Paper Scissors!'
  end

  def play
    display_welcome_message
    winner = nil
    loop do
      human.choose
      computer.choose
      display_winner
      if human.score == 5
        winner = human
        break
      elsif computer.score == 5
        winner = computer
        break
      end
      binding.pry
    end
    puts "#{winner.name} finnaly win!!!"
    display_goodbye_message
  end
end

RPSGame.new.play
