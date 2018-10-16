require 'pry'
#
module Displayable
  def display
    puts ''
    (1..(scale**2)).step(scale) do |cell_number|
      puts celle_in_a_line(cell_number)
      puts seperate_line unless cell_number == scale**2 - scale + 1
    end
    puts ''
  end

  def celle_in_a_line(cell_number)
    [first_line_from(cell_number),
     third_line,
     second_line_from(cell_number),
     third_line,
     third_line]
  end

  def first_line_from(cell_number)
    (cell_number..(cell_number + scale - 1)).map do |ord|
      ord.to_s.ljust(11)
    end.join('|')
  end

  def second_line_from(cell_number)
    lines = []
    (cell_number..(cell_number + (scale - 1))).each do |n|
      mark = cells[n] || ' '
      in_a_unit = ' ' * 5 + mark + ' ' * 5
      lines << in_a_unit
    end
    lines.join('|')
  end

  def third_line
    ([' ' * 11] * scale).join('|')
  end

  def seperate_line
    ('- ' * (scale * 6))
  end
end
# ------------------------------------------------------------------------------
module Winnable
  def l_to_r_diagonal_diff
    scale + 1
  end

  def r_to_l_diagonal_diff
    scale - 1
  end

  def l_edge_nums
    (1..scale**2 - scale + 1).step(scale).to_a
  end

  def r_edge_nums
    (scale..scale**2).step(scale).to_a
  end

  def lr_edge_nums
    l_edge_nums + r_edge_nums
  end

  def ud_edge_nums
    ud_edge_nums = (1..scale).to_a
    scale.times { |n| ud_edge_nums << scale**2 - n }
    ud_edge_nums
  end

  def edge_nums
    ud_edge_nums + lr_edge_nums
  end

  def one_of_win_com?(array_with_three)
    arr = array_with_three.sort
    c1 = win_horizontally?(arr)
    c2 = win_vertically?(arr)
    c3 = win_diagonally?(arr)
    c1 || c2 || c3
  end

  def consecutive_with_diff?(array_with_three, diff)
    array_with_three[2] - array_with_three[1] == diff &&
      array_with_three[1] - array_with_three[0] == diff
  end

  def win_horizontally?(array_with_three)
    consecutive_with_diff?(array_with_three, 1) &&
      lr_edge_nums.none? { |edge_num| array_with_three[1] == edge_num }
  end

  def win_vertically?(array_with_three)
    consecutive_with_diff?(array_with_three, scale)
  end

  def win_diagonally?(array_with_three)
    condition1 =
      consecutive_with_diff?(array_with_three, l_to_r_diagonal_diff)
    condition2 =
      consecutive_with_diff?(array_with_three, r_to_l_diagonal_diff)
    (condition1 || condition2) && not_in_a_line?(array_with_three)
  end

  def not_in_a_line?(array_with_three)
    lr_edge_nums.none? { |edge_num| array_with_three[1] == edge_num }
  end

  def calculate_win_coms
    (1..scale**2).to_a.combination(3).select do |choiced_nums|
      one_of_win_com?(choiced_nums)
    end
  end
end
# ------------------------------------------------------------------------------
class Board
  include Displayable
  include Winnable
  attr_reader :cells, :scale, :win_coms

  def initialize(scale)
    @scale = scale
    @cells = {}
    (1..(scale**2)).each { |ord| @cells[ord] = nil }
    @win_coms = calculate_win_coms
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
    win_coms.each do |win_com|
      if (win_com & human_choices).size == 2
        next_move = win_com - human_choices
        moves << next_move.first if empty_cells.include?(next_move.first)
      end
    end
    moves
  end

  def offensive_moves
    moves = []
    win_coms.each do |win_com|
      if (win_com & npc_choices).size == 2
        next_move = win_com - npc_choices
        moves << next_move.first if empty_cells.include?(next_move.first)
      end
    end
    moves
  end
end
# ------------------------------------------------------------------------------
class Array
  def ttt_join(punctuation = ',', word = 'or')
    case size
    when 1 then self[0].to_s
    when 2 then "#{self[0]} #{word} #{self[1]}"
    else
      self[0..-2].join("#{punctuation} ") + "#{punctuation} #{word} #{self[-1]}"
    end
  end
end
# ------------------------------------------------------------------------------
class Player
  attr_reader :species, :name
  attr_accessor :score, :mark

  def initialize(species = :human)
    @species = species
    @score = 0
    @mark = set_mark
    @name = set_name
  end

  def set_mark
    case species
    when :npc then 'O'
    when :human then ask_for_mark
    end
  end

  def ask_for_mark
    puts "\n\nChoose your mark(1 character), letter 'O' has been taken: "
    answer = gets.chomp.upcase
    if answer.length == 1 && answer != ' ' && answer != 'O'
      answer
    else
      puts 'Invalid choice!'
      ask_for_mark
    end
  end

  def set_name
    case species
    when :npc then 'ET8000'
    when :human then ask_for_name
    end
  end

  def ask_for_name
    puts 'Enter your name: '
    answer = gets.chomp.strip
    if answer.empty?
      puts 'Name should not be emtpy, try again!'
      ask_for_name
    else
      answer.capitalize
    end
  end
end
# ------------------------------------------------------------------------------
class TTTGame
  attr_reader :board, :human, :npc, :board_scale
  attr_accessor :winner, :current_turn

  WINING_SCORE = 2
  FIRST_MOVE = 'human'.freeze

  def initialize
    put_instruction
    @human = Player.new
    @npc = Player.new(:npc)
    @board_scale = ask_for_scale
    reset_board
  end

  def put_instruction
    puts(<<-M)

      Welcome to Tic Tac Toe!
      Before playing you have 3 things to set:

        1)your own mark
        2)your user name
        3)the scale of the game board

      The game would begin.
      Who first got 3 marks in a line would win a round.
                    ^
    M
  end

  def ask_for_scale
    puts "Choose a board scale (bigger than 3, but better less than 10):"
    answer = gets.chomp
    if answer.to_i.to_s == answer && answer.to_i >= 3
      answer.to_i
    else
      puts 'Invalid scale!'
      ask_for_scale
    end
  end

  def reset_board
    @board = Board.new(board_scale)
    @winner = nil
    @current_turn = FIRST_MOVE
  end

  def reset_scores
    human.score = 0
    npc.score = 0
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
    puts ''
    puts "The final winner is #{winner}!".center(80, ' * ')
  end

  def prompt_new_round
    puts ''
    puts 'New Round. Fight!'.center(80, ' - ')
  end

  def play_again?
    puts 'Play again? (Y / N)'
    answer = gets.chomp
    answer.downcase.start_with?('y') ? true : false
  end

  def play_a_round
    prompt_new_round
    display_board
    loop do
      current_player_moves
      break if someone_won_a_round? || board_full?
    end
  end

  def report_score
    human_score = "#{human.name}(#{human.score})"
    npc_score = "#{npc.name}(#{npc.score})"
    puts "\nCurrent scores: #{human_score} VS #{npc_score}"
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
    if winner == npc.name
      npc.score += 1
    elsif winner == human.name
      human.score += 1
    end
  end

  def npc_moves
    move = npc_make_choice
    board.cells[move] = npc.mark
    self.current_turn = 'human'
    display_board
  end

  def npc_make_choice
    prior_cell = (board.empty_cells - board.edge_nums).sample
    board.offensive_moves.sample ||
      board.defensive_moves.sample ||
      prior_cell ||
      board.empty_cells.sample
  end

  def i_move
    move = ask_for_move
    board.cells[move] = human.mark
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
      self.winner = human.name
      true
    elsif did_npc_win?
      self.winner = npc.name
      true
    else
      false
    end
  end

  def someone_won_the_game?
    human.score == WINING_SCORE || npc.score == WINING_SCORE
  end

  def did_i_win?
    board.win_coms.any? { |win_com| (board.human_choices & win_com).size == 3 }
  end

  def did_npc_win?
    board.win_coms.any? { |win_com| (board.npc_choices & win_com).size == 3 }
  end

  def clear
    system 'clear'
  end
end

game = TTTGame.new
game.play
