# top class
class Player
  attr_accessor :choice, :name, :score, :choices

  def initialize
    set_name
    @score = 0
    @choices = []
  end
end
# ------------------------------------------------------------------------------
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
      self.name = answer.split.map(&:capitalize).join(' ')
    end
  end

  def choose
    choice = nil
    loop do
      puts "\nPlease choose from (#{Choice::MOVES.join(', ')}): "
      choice = gets.chomp
      break if Choice::MOVES.include?(choice)
      puts 'Sorry, invalid choice!'
    end
    chosed = Choice.new(choice)
    self.choice = chosed
    choices << chosed.value
  end
end
# ----------------------------------------------------------------------
class Computer < Player
  attr_accessor :weights, :personality

  def initialize
    @personality = Personality.new
    super
  end

  def set_name
    self.name = personality.type + ' ' + ('a'..'z').to_a.sample(4).join.upcase
  end

  def weightest_choice
    personality.weights.max_by { |_, v| v }[0]
  end

  def choose
    chosed = Choice.new(weightest_choice)
    self.choice = chosed
    choices << chosed.value
  end
end
# ------------------------------------------------------------------------------
module Stylable
  def lazilize
    weights[preference] *= 1.2
  end

  def rockilize
    weights['rock'] *= 1.2
  end

  def stubbornize
    weights.each { |k, _| weights[k] = 0 unless k == preference }
  end

  def casualize
    weights.each { |k, _| weights[k] = rand(100) }
  end
end
# ------------------------------------------------------------------------------
class Personality
  include Stylable
  attr_accessor :type, :preference, :weights
  TYPES = %w(Rocky Stubborn Casual Lazy).freeze
  # lazy: choose one option and continuely allocate more weight to this choice
  # rocky: will allocate more weight to rock, always
  # stubborn: randomly choose one item then stick to it
  # casual: randomly chooses

  def initialize
    @type = TYPES.sample
    if @type == 'Lazy' || @type == 'Stubborn'
      @preference = Choice::MOVES.sample
    elsif @type == 'Rocky'
      @preference = 'rock'
    end
    @weights = {}
    Choice::MOVES.each { |choice| @weights[choice] = 20 }
  end

  def reallocate_weights(last_winner, last_choice)
    case last_winner
    when 'human'
      @weights[last_choice] -= 10
    when 'computer'
      @weights[last_choice] += 10
    end
    readjust_weights
  end

  def readjust_weights
    case type
    when 'Lazy' then lazilize
    when 'Rocky' then rockilize
    when 'Stubborn' then stubbornize
    when 'Casual' then casualize
    end
  end
end
# ------------------------------------------------------------------------------
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
    c1 = value
    c2 = other.value
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
# ------------------------------------------------------------------------------
class RPSGame
  attr_accessor :human, :computer, :finnal_winner, :last_winner
  @@winning_score = 1

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def set_winning_score
    puts "\nPlease set a winning score(number of rounds to win): "
    answer = gets.chomp
    if answer.to_i.to_s == answer
      @@winning_score = answer.to_i
      puts " The one who first won #{@@winning_score} \
  rounds would be the finnal winner".centralize
    else
      puts 'You should enter a number: '
      set_winning_score
    end
  end

  def display_goodbye_message
    puts 'Thanks for playing this game. Goodbye!'
  end

  def find_winner
    self.last_winner =
      if human.choice == computer.choice
        'none'
      elsif human.choice > computer.choice
        'human'
      else
        'computer'
      end
  end

  def display_winner
    case last_winner
    when 'none'
      puts 'It\'s a Tie this round!!!'
    when 'computer'
      puts 'You Lost this round!!!'
    else
      puts 'You Won this round!!!'
    end
  end

  def conclude
    find_winner
    display_winner
    update_scores
    computer.personality.reallocate_weights(last_winner, computer.choice.value)
  end

  def update_scores
    case last_winner
    when 'human' then human.score += 1
    when 'computer' then computer.score += 1
    end
    display_score
  end

  def display_score
    puts "\nCurrent socres: #{human.name}( #{human.score} ) \
VS #{computer.name}( #{computer.score} )"
  end

  def display_choices
    puts "\n#{human.name} chose [#{human.choice}]"
    puts "#{computer.name} chose [#{computer.choice}]"
  end

  def operate_game
    if computer.score >= @@winning_score
      self.finnal_winner = computer
    elsif human.score >= @@winning_score
      self.finnal_winner = human
    else
      round_fight
      operate_game
    end
  end

  def round_fight
    human.choose
    computer.choose
    display_choices
    conclude
  end

  def display_players
    puts " #{human.name} VS #{computer.name} ".centralize('-')
  end

  def begin
    puts ' Welcome to Rock Paper Scissors! '.centralize
    set_winning_score
    display_players
    operate_game
    puts "#{finnal_winner.name} finnaly won!!!".centralize('-')
    display_goodbye_message
  end
end
# ------------------------------------------------------------------------------
class String
  def centralize(sym = ' ')
    center(80, sym)
  end
end

RPSGame.new.begin
