require 'pry'
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

  def npc_choices
    cells.select { |_, owner| owner == 'O' }.keys
  end

  def human_choices
    cells.select { |_, owner| owner == 'X' }.keys
  end

  def defensive_moves
    moves = []
    WIN_COMS.each do |win_com|
      if (win_com & human_choices).size == 2
        possible_move = win_com - human_choices
        moves << possible_move.first if empty_cells.include?(possible_move.first)
      end
    end
    moves
  end

  def offensive_moves
    moves = []
    WIN_COMS.each do |win_com|
      if (win_com & npc_choices).size == 2
        possible_move = win_com - npc_choices
        moves << possible_move.first if empty_cells.include?(possible_move.first)
      end
    end
    moves
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

class Player
  attr_reader :species
  attr_accessor :score

  def initialize(species = :human)
    @species = species
    @score = 0
  end
end

# ------------------------------------------------------------------------------
class TTTGame
  attr_reader :board, :human, :npc
  attr_accessor :winner, :current_turn

  WINING_SCORE = 2
  FIRST_MOVE = 'npc'.freeze

  def initialize
    @human = Player.new
    @npc = Player.new(:npc)
    reset_board
  end

  def reset_board
    @board = Board.new
    @winner = nil
    @current_turn = FIRST_MOVE
  end

  def reset_scores
    self.human.score = 0
    self.npc.score = 0
  end

  def display_board
    board.display
  end

  def greet
    puts 'Welcome to Tic Tac Toe!'
  end

  def say_goodbye
    puts "\nGoodbye. Thanks for playing TTT!"
  end

  def play
    clear
    greet
    loop do
      reset_scores
      play_a_set
      break unless play_again?
    end
    say_goodbye
  end

  def play_a_set
    loop do
      reset_board
      play_a_round
      update_scores
      display_result
      break if someone_won_the_game?
    end
    report_set_winner
  end

  private

  def report_set_winner
    puts ""
    puts "The final winner is #{winner}!".center(80, ' * ')
  end

  def prompt_new_round
    puts "New Round. Fight!".center(80, ' - ')
  end

  def play_again?
    puts 'Play again? (Y / N)'
    answer = gets.chomp
    answer.downcase.start_with?('y') ? true : false
  end

  def play_a_round
    prompt_new_round
    loop do
      current_player_moves
      break if someone_won_a_round? || board_full?
    end
  end

  def report_score
    puts "\nCurrent scores: Human(#{human.score}) VS NPC(#{npc.score})"
  end

  def current_player_moves
    case current_turn
    when 'human' then i_move
    when 'npc' then npc_moves
    end
  end

  def display_result
    if winner == 'Tie'
      puts "It's a tie!"
    else
      puts "\n#{winner} won this round!"
    end
    report_score
  end

  def update_scores
    if winner == 'Npc'
      npc.score += 1
    elsif winner == 'Human'
      human.score += 1
    end
  end

  def npc_moves
    fifth_cell = 5 if board.empty_cells.include?(5)
    move =
      board.offensive_moves.sample ||
      board.defensive_moves.sample ||
      fifth_cell ||
      board.empty_cells.sample
    board.cells[move] = 'O'
    self.current_turn = 'human'
    display_board
  end

  def i_move
    move = ask_for_move
    board.cells[move] = 'X'
    self.current_turn = 'npc'
    clear
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

  def board_full?
    full_or_not = board.empty_cells.empty?
    self.winner = 'Tie' if full_or_not
    full_or_not
  end

  def someone_won_a_round?
    if did_i_win?
      self.winner = 'Human'
      true
    elsif did_npc_win?
      self.winner = 'Npc'
      true
    else
      false
    end
  end

  def someone_won_the_game?
    human.score == WINING_SCORE || npc.score == WINING_SCORE
  end

  def did_i_win?
    Board::WIN_COMS.any? { |win_com| (board.human_choices & win_com).size == 3 }
  end

  def did_npc_win?
    Board::WIN_COMS.any? { |win_com| (board.npc_choices & win_com).size == 3 }
  end

  def clear
    system 'clear'
  end
end

game = TTTGame.new
game.play
