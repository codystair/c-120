#
module Displayable
  def display
    puts(<<-BOARD)

                      |         |
      #{line_start_from(1)}
                      |         |
            - - - - - - - - - - - - - - - -
                      |         |
      #{line_start_from(4)}
                      |         |
            - - - - - - - - - - - - - - - -
                      |         |
      #{line_start_from(7)}
                      |         |

      BOARD
  end

  def line_start_from(cell_number)
    "           #{cells[cell_number] || ' '}    |    #{cells[cell_number + 1] || ' '}    |    #{cells[cell_number + 2] || ' '}"
  end
end

# ------------------------------------------------------------------------------
class Board
  include Displayable
  attr_reader :cells

  WIN_COMS = [
    [1, 2, 3], [4, 5, 6], [7, 8, 9],
    [1, 4, 7], [2, 5, 8], [3, 6, 9],
    [1, 5, 9], [7, 5, 3]
  ].freeze

  def initialize
    @cells = {}
    (1..9).each { |ord| @cells[ord] = nil }
  end

  def empty_cells
    cells.select { |_, owner| owner.nil? }.keys
  end
end
# ------------------------------------------------------------------------------
class Array
  def ttt_join(punctuation = ',', word = 'or')
    case size
    when 1 then "#{self[0]}"
    when 2 then "#{self[0]} #{word} #{self[1]}"
    else
      self[0..-2].join("#{punctuation} ") + "#{punctuation} #{word} #{self[-1]}"
    end
  end
end


# ------------------------------------------------------------------------------
class TTTGame
  attr_reader :board
  attr_accessor :winner, :current_turn

  FIRST_MOVE = 'npc'.freeze

  def initialize
    reset_game
  end

  def reset_game
    @board = Board.new
    @winner = nil
    @current_turn = FIRST_MOVE
  end

  def display_board
    clear
    board.display
  end

  def greet
    puts 'Welcome to Tic Tac Toe!'
  end

  def say_goodbye
    puts 'Goodbye. Thanks for playing TTT!'
  end

  def play
    loop do
      reset_game
      display_board
      greet
      play_a_round
      display_result
      break unless play_again?
    end
    say_goodbye
  end

  private

  def play_again?
    puts 'Play again? (Y / N)'
    answer = gets.chomp
    answer.downcase.start_with?('y') ? true : false
  end

  def play_a_round
    loop do
      current_player_moves
      break if someone_won? || board_full?
    end
  end

  def current_player_moves
    case current_turn
    when 'me' then i_move
    when 'npc' then npc_moves
    end
  end

  def display_result
    display_board
    if winner == 'tie'
      puts "It's a tie!"
    else
      puts "\n#{winner} won the game!"
    end
  end

  def npc_moves
    move = board.empty_cells.sample
    board.cells[move] = 'O'
    self.current_turn = 'me'
    display_board
  end

  def i_move
    move = ask_for_move
    board.cells[move] = 'X'
    self.current_turn = 'npc'
  end

  def ask_for_move
    puts "Choose your next move, from: #{board.empty_cells.ttt_join}"
    answer = gets.chomp.to_i
    if board.empty_cells.include?(answer)
      answer
    else
      puts 'Invalid input!'
      ask_for_move
    end
  end

  def npc_choices
    board.cells.select { |_, owner| owner == 'O' }.keys
  end

  def my_choices
    board.cells.select { |_, owner| owner == 'X' }.keys
  end

  def board_full?
    full_or_not = board.empty_cells.empty?
    self.winner = 'tie' if full_or_not
    full_or_not
  end

  def someone_won?
    if did_i_win?
      self.winner = 'You'
      true
    elsif did_npc_win?
      self.winner = 'Npc'
      true
    else
      false
    end
  end

  def did_i_win?
    Board::WIN_COMS.any? { |win_com| (my_choices & win_com).size == 3 }
  end

  def did_npc_win?
    Board::WIN_COMS.any? { |win_com| (npc_choices & win_com).size == 3 }
  end

  def clear
    system 'clear'
  end
end

game = TTTGame.new
game.play
