# instantiate a new GuessingGame object(game)
# call `play` on game
# circle
  # show the remaining number of guessing chances
  # show available numbuers can be chosen
  # takes in a number from user
    # verify the legality of the input number
  # match the guessing
    # report the result
  # update the remaining number of guessing chances
# circle end if the remaining number of guessing chances were used out


class GuessingGame
  attr_reader :target
  attr_accessor :current_guessing, :number_of_chances, :game_over

  def initialize
    @number_of_chances = 7
    @target = rand(100) + 1
    @current_guessing = nil
    @game_over = false
  end

  def play
    initialize if game_over?
    loop do
      report_remaining_chances
      ask_number
      match_and_report
      update_remaining_chances
      break if game_over?
    end
    report_result
  end

  private

  def game_over?
    if number_of_chances == 0 || current_guessing == target
      self.game_over = true
      true
    else
      false
    end
  end

  def report_result
    if number_of_chances == 0
      puts "You are out of guesses. You lose."
    elsif current_guessing == target
      puts "You win!"
    end
  end

  def report_remaining_chances
    puts "You have #{number_of_chances} guesses remaining."
  end

  def ask_number
    print "Enter a number between 1 and 100:"
    answer = gets.chomp
    if answer.to_i.to_s == answer && (1..100).include?(answer.to_i)
      self.current_guessing = answer.to_i
    else
      print "Invalid guess."
      ask_number
    end
  end

  def match_and_report
    if current_guessing == target
      return
    else
      evaluate
    end
  end

  def evaluate
    if current_guessing > target
      puts "Your guess is too high"
    elsif current_guessing < target
      puts "Your guess is too low"
    end
  end

  def update_remaining_chances
    self.number_of_chances -= 1
  end
end

game = GuessingGame.new
game.play

game.play
