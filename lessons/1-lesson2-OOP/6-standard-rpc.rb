# top class
require 'pry'
class Player
  attr_accessor :choice, :name, :score

  def initialize
    set_name
    @score = 0
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
    self.choice = Choice.new(choice)
  end
end
# ----------------------------------------------------------------------
class Computer < Player
  def set_name
    self.name = ('a'..'z').to_a.sample(4).join.upcase
  end

  def choose
    self.choice = Choice.new(Choice::MOVES.sample)
  end
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
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_goodbye_message
    puts 'Thanks for playing this game. Goodbye!'
  end

  def verdict(human, computer)
    if human.choice == computer.choice
      puts 'It\'s a Tie in this round!!!'
      puts "#{human.name}(#{human.score}) VS #{computer.name}(#{computer.score})"
    elsif human.choice > computer.choice
      human.score += 1
      puts 'You Won in this round!!!'
      puts "#{human.name}(#{human.score}) VS #{computer.name}(#{computer.score})"
    else
      computer.score += 1
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

  # def stop?
  #   puts 'Do you want to play again?(Y or N)'
  #   answer = gets.chomp
  #   if answer.downcase.start_with?('n')
  #     true
  #   elsif answer.downcase.start_with?('y')
  #     false
  #   else
  #     puts 'Invalid request'
  #     stop?
  #   end
  # end

  def play
    display_welcome_message
    winner = nil
    loop do
      human.choose
      computer.choose
      display_winner
      if human.score == 3
        winner = human
        break
      elsif computer.score == 3
        winner = computer
        break
      end
    end
    puts "#{winner.name} finnaly win!!!"
    display_goodbye_message
  end
end

RPSGame.new.play
