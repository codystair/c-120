# top class
class Player
  attr_accessor :choice, :name, :score, :choices

  def initialize
    set_name
    @score = 0
    @choices = []
  end

  def to_s
    @name
  end
end
# ------------------------------------------------------------------------------
class Human < Player
  def set_name
    puts 'Set your name: '
    answer = gets.chomp
    if answer.squeeze == ' ' || answer == ''
      puts 'Name can not be set to empty!'
      ask_name
    else
      self.name = answer.split.map(&:capitalize).join(' ')
    end
  end

  def regularize_choice(choice)
    Choice::MOVES_AND_WINS.keys.each do |full_move|
      if choice.downcase.start_with?('s')
        return '' if choice.length < 2
        return full_move if full_move.match(Regexp.new(choice[0, 2], true))
      elsif full_move.start_with?(choice.downcase)
        return full_move
      end
    end
  end

  def ask_choice
    answer = gets.chomp # r or rock
    regularize_choice(answer)
  end

  def choose
    choice = nil
    loop do
      choice = ask_choice
      break if Choice::MOVES_AND_WINS.keys.include?(choice)
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

  def reset_personality
    personality.set_type
    personality.set_preference
    personality.set_weights
    set_name
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
  TYPES = %w[Rocky Stubborn Casual Lazy].freeze
  # lazy: choose one option and continuely allocate more weight to this choice
  # rocky: will allocate more weight to rock, always
  # stubborn: randomly choose one item then stick to it
  # casual: randomly chooses

  def initialize
    set_type
    set_preference
    set_weights
  end

  def set_preference
    if @type == 'Lazy' || @type == 'Stubborn'
      @preference = Choice::MOVES_AND_WINS.keys.sample
    elsif @type == 'Rocky'
      @preference = 'rock'
    end
  end

  def set_weights
    @weights = {}
    Choice::MOVES_AND_WINS.keys.each { |choice| @weights[choice] = 20 }
  end

  def set_type
    @type = TYPES.sample
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
  MOVES_AND_WINS = {
    'rock' => %w[scissors lizard],
    'paper' => %w[rock spock],
    'scissors' => %w[paper lizard],
    'lizard' => %w[spock paper],
    'spock' => %w[rock scissors]
  }.freeze
  attr_accessor :value
  def initialize(value)
    @value = value
  end

  def <=>(other)
    c1 = value
    c2 = other.value
    if MOVES_AND_WINS[c1].include?(c2)
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
    system('clear')
    puts ' Hello! Welcome to Rock Paper Scissors! '.centralize
    @human = Human.new
    @computer = Computer.new
  end

  def set_game
    puts "\nPlease set a winning score(number of rounds to win): "
    answer = gets.chomp
    if answer.to_i.to_s == answer
      @@winning_score = answer.to_i
      puts " Who got #{@@winning_score} scores would be the winner!".centralize
    else
      puts 'You should enter a number: '
      set_game
    end
  end

  def display_players
    puts " #{human.name} VS #{computer.name} ".centralize('-')
  end

  def display_rule
    puts "\nPlease choose from (#{Choice::MOVES_AND_WINS.keys.join(', ')}): "
    puts 'Or use simplified: (r, p, sc, l, sp)'
  end

  def update_winner
    self.last_winner =
      if human.choice == computer.choice then 'none'
      elsif human.choice > computer.choice then 'human'
      else 'computer'
      end
  end

  def update_scores
    case last_winner
    when 'human' then human.score += 1
    when 'computer' then computer.score += 1
    end
  end

  def update_game_info
    update_winner
    update_scores
    computer.personality.reallocate_weights(last_winner, computer.choice.value)
    display_unit_result
  end

  def display_choices
    system('clear')
    puts "(You)[#{human.choice}] VS [#{computer.choice}](#{computer.name})"
  end

  def display_scores
    puts "\nScores: #{human}(#{human.score}) VS #{computer}(#{computer.score})"
  end

  def display_winner
    if last_winner == 'none' then puts "\nIt's a Tie this round!"
    elsif last_winner == 'human' then puts "\n#{human} Won this round."
    else puts "\n#{computer} Won this round."
    end
  end

  def display_unit_result
    display_choices
    display_winner
    display_scores
  end

  def play_again?
    puts "\nPlay again? Press 'y' to continue, any other input to exit"
    answer = gets.chomp
    answer.downcase.start_with?('y') ? true : false
  end

  def display_final_winner
    winner = [human, computer].select do |player|
      player.score == @@winning_score
    end[0]
    puts " #{winner.name} won this set! ".centralize('-')
  end

  def reset_game
    human.score = 0
    computer.score = 0
    computer.reset_personality
  end

  def run_a_round
    loop do
      display_rule
      human.choose
      computer.choose
      update_game_info
      if human.score == @@winning_score || computer.score == @@winning_score
        display_final_winner
        break
      end
    end
  end

  def run_a_game
    set_game
    loop do
      display_players
      run_a_round
      break unless play_again?
      reset_game
    end
  end
end
# ------------------------------------------------------------------------------
class String
  def centralize(sym = ' ')
    center(80, sym)
  end
end

RPSGame.new.run_a_game
