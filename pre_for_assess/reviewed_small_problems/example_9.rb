class GuessingGame
  attr_accessor :guessing, :chances_remained, :target

  def reset_game
    self.chances_remained = 7
    self.target = rand(1..100)
  end

  def play
    reset_game
    loop do
      prompt_chances_remained
      ask_for_guessing
      evaluate
      break if win? || out_of_chance?
    end
  end

  private

  def prompt_chances_remained
    puts "You have #{chances_remained} guesses remaining."
  end

  def ask_for_guessing
    print "Enter a number between 1 and 100: "
    answer = gets.chomp
    if answer.to_i.to_s == answer && (1..100).include?(answer.to_i)
      self.guessing = answer.to_i
      self.chances_remained -= 1
    else
      puts "Invalid guess."
      ask_for_guessing
    end
  end

  def evaluate
    if win?
      puts "You win!"
    elsif out_of_chance?
      puts "You are out of guesses. You lose."
    else
      report_comparing_result
    end
    puts ''
  end

  def report_comparing_result
    if guessing > target
      puts "Your guess is too high."
    else
      puts "Your guess is too low."
    end
  end

  def win?
    guessing == target
  end

  def out_of_chance?
    chances_remained == 0
  end
end

game = GuessingGame.new
game.play

game.play
