# ------------------------------------------------------------------------------
module Instruction
  def introduce_rule
    clear_screen
    puts(<<-M)

--------------------- Welcome to [21 point] card game! ---------------------

      The basic rules are:
        - You and Npc will both get 2 cards initially.
        - Every round you could choose to stay or hit.
        - The one who's more close to 21 would be the winner.
        - But the one who first surpasses 21 will get busted, means lost.
        - One of the Npc's card is always invisible for you.
        - Before Npc's total is less than or equal to 17, it must choose to hit.
        - If both players choose to stay, the game would end up comparing players' total
          and get a conclusion.

        - The value of 'A's cards is dynamically changing:
          1) initially all 'A's' value will set to 14
          2) if the total of your cards is greater than 21
            # system will automatically change one of your 'A's value to 1
            # this process will continue until:
                a. your total is less than 21
                   or
                b. all your 'A's have been degraded.
    M
  end
end
# ------------------------------------------------------------------------------
class Player
  attr_reader :species, :name
  attr_accessor :current_move, :cards_in_hand

  def initialize(species)
    @cards_in_hand = []
    @species = species
  end

  def total
    pre_sum = sum_of_cards_value
    if pre_sum > 21 && big_ace_count >= 1
      readjust_cards_value
      sum_of_cards_value
    else
      pre_sum
    end
  end

  def busted?
    puts "#{species.capitalize} busted!".center(80) if total > 21
    total > 21
  end

  private

  def readjust_cards_value
    if big_ace_count == 1
      degrade_an_ace
    elsif big_ace_count > 1
      degrade_an_ace until sum_of_cards_value <= 21 || big_ace_count == 0
    end
  end

  def aces_with_big_value
    cards_in_hand.select { |card| card.rank == 'A' && card.value == 14 }
  end

  def big_ace_count
    aces_with_big_value.count
  end

  def degrade_an_ace
    ace = aces_with_big_value.first
    ace.value = 1
  end

  def sum_of_cards_value
    cards_in_hand.inject(0) { |acc, card| acc + card.value }
  end
end
# ------------------------------------------------------------------------------
class Game
  include Instruction
  attr_reader :human, :npc, :cards_pool

  def initialize
    @cards_pool = Deck.new.cards
    initialize_players
  end

  def play
    introduce_rule
    loop do
      play_a_round
      break unless play_again?
    end
  end

  private

  def initialize_cards
    [human, npc].each do |player|
      player.cards_in_hand = []
      2.times { deal_to(player) }
    end
    npc.cards_in_hand.first.state = :private
  end

  def prompt_new_round
    clear_screen
    puts "\n\n"
    puts ' New round fight '.center(80, ' - ')
  end

  def ask_for_move
    puts "\nPlease evaluate your cards in hand, choose to hit or stay (h / s):"
    answer = gets.chomp
    if answer.downcase.start_with?('s', 'h')
      answer.downcase[0]
    else
      puts 'Invalid choice! Try again.'
      ask_for_move
    end
  end

  def human_make_choice
    move = ask_for_move
    if move == 'h'
      human.current_move = 'hit'
      deal_to(human)
    elsif move == 's'
      human.current_move = 'stay'
    end
    clear_screen
    puts "\nYou chose to #{human.current_move}"
  end

  def clear_screen(new_game = false)
    system('clear') || system('cls') unless new_game
  end

  def npc_make_choice
    if npc.total <= 17
      npc.current_move = 'hit'
      deal_to(npc)
    else
      npc.current_move = 'stay'
    end
    puts "\nNpc chose to #{npc.current_move}"
  end

  def both_staying?
    human.current_move == 'stay' && npc.current_move == 'stay'
  end

  def report_result
    puts "\nBoth players chose to stay ..." if both_staying?
    result =
      case find_out_winner
      when 'tie' then " It's a tie! "
      when 'human' then " Human won this round! "
      when 'npc' then " Npc won this round! "
      end
    puts("\n" + result.center(80, ' * ') + "\n")
    show_values
  end

  def tie?
    human.total == npc.total
  end

  def show_values
    puts ''
    puts "#{human.total}(you) VS #{npc.total}(npc)".center(80)
  end

  def winner_without_busted
    human.total < npc.total ? 'npc' : 'human'
  end

  def find_out_winner
    if tie?
      'tie'
    elsif human.total <= 21 && npc.total <= 21
      winner_without_busted
    elsif human.total > 21
      'npc'
    elsif npc.total > 21
      'human'
    end
  end

  def play_a_round
    new_game = true
    initialize_cards
    loop do
      clear_screen(new_game)
      display_cards
      human_make_choice
      break if human.busted?
      npc_make_choice
      break if npc.busted? || both_staying? || tie?
    end
    report_result
    display_cards(true)
  end

  def play_again?
    puts "\n\n"
    puts " Do you wanna play again?(Y / N): ".center(80, ' - ')
    answer = gets.chomp
    if answer.downcase.start_with?('y')
      prompt_new_round
      return true
    elsif answer.downcase.start_with?('n')
      return false
    else
      puts 'Invalid request, try again.'
      play_again?
    end
  end

  def deal_to(player)
    player.cards_in_hand << cards_pool.pop
  end

  def display_cards(game_over = false)
    npc.cards_in_hand.first.state = :public if game_over
    display_all_cards
  end

  def display_all_cards
    puts "\nYour cards are: "
    human.cards_in_hand.each { |card| puts card }
    puts "\nNpc's cards are: "
    npc.cards_in_hand.each { |card| puts card }
  end

  def initialize_players
    @human = Player.new(:human)
    @npc = Player.new(:npc)
  end
end
# ------------------------------------------------------------------------------
class Deck
  SUIT = %w[Hearts Diamonds Spades Clubs]
  RANK = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A']
  attr_reader :cards

  def initialize
    @cards = []
    SUIT.each do |suit|
      RANK.each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end
# ------------------------------------------------------------------------------
class Card
  attr_reader :suit, :rank
  attr_accessor :state, :value

  @values = {}
  class << self; attr_accessor :values; end

  def self.insert_values
    Deck::RANK.each.with_index(2) do |rank, value|
      @values[rank] = value
    end
  end

  insert_values

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
    @state = :public
    @value = Card.values[@rank]
  end

  def to_s
    if state == :public
      "#{rank} of #{suit}"
    elsif state == :private
      "[unknown] of #{suit}"
    end
  end
end

Game.new.play
