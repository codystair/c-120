# pair 一个对子 + 三张随机

# two pair 两个对子 + 一张随机

# three of a kind 有三张相同 + 两张随机

# full house 三张相同 + 两张相同
  # a poker hand with three of a kind and a pair, which beats a flush and loses to four of a kind

# four of a kind 四张相同的牌

# straight 普通顺子（不同花）

# flush 同花(但不是顺子)

# royal flush 同花大顺
  # (Poker)a straight flush including ace, king, queen, jack, and ten all in the same suit, which is the hand of the highest possible value when wild cards are not in use
  # same suit with （10, jack, queen, king, ace） in hand

# straight flush 同花顺子
  # a hand of playing cards in poker that contains five cards of the same suit in sequence (such as a five, a six, a seven, an eight, and a nine of clubs)
  # same suit with consecutive 5 cards but not royal flush for example:
    # 3,4,5,6,7
    # 9,10,jack,queen,king


require 'pry'

class Card
  include Comparable
  attr_accessor :rank, :suit

  RANK_VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    self.rank = rank
    self.suit = suit
  end

  def rank_value
    RANK_VALUES[rank] || rank
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(another)
    rank_value <=> another.rank_value
  end
end

class Deck
  attr_accessor :cards
  RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'].freeze
  SUITS = ['Spades', 'Hearts', 'Clubs', 'Diamonds'].freeze

  def initialize
    self.cards = new_deck_of_cards
  end

  def draw
    self.cards = new_deck_of_cards if cards.empty?
    cards.pop
  end

  private

  def new_deck_of_cards
    cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        cards << Card.new(rank, suit)
      end
    end
    cards.shuffle!
  end
end

module Pokable
  def count_ranks
    hash = Hash.new(0)
    deck.each { |card| hash[card.rank] += 1 }
    hash
  end

  def count_suits
    hash = Hash.new(0)
    deck.each { |card| hash[card.suit] += 1 }
    hash
  end

  def royal_flush?
    straight_flush? && deck.first.rank == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    count_ranks.values.include?(4)
  end

  def full_house?
    count_ranks.values.sort == [2, 3]
  end

  def flush?
    count_suits.size == 1
  end

  def straight?
    4.times do |idx|
      return false if (deck[idx+1].rank_value - deck[idx].rank_value) != 1
    end
    true
  end

  def three_of_a_kind?
    count_ranks.values.include?(3)
  end

  def two_pair?
    count_ranks.values.count(2) == 2
  end

  def pair?
    count_ranks.values.count(2) == 1
  end
end

class PokerHand
  include Pokable
  attr_reader :deck

  def initialize(deck)
    deck = deck.is_a?(Array) ? deck : deck.cards.first(5)
    @deck = deck.sort_by { |card| card.rank_value }
  end

  def print
    deck.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate
# Danger danger danger: monkey
# patching for testing purposes.
class Array
  include Pokable
  alias_method :draw, :pop
end



# Test that we can identify each PokerHand type.
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'
#
hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'
#
hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'
#
hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'
#
hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'
#
hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'
#
hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'
#
hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'

# How would you modify our original solution to choose the best hand between two poker hands?
  # create a hash that hold the weight for all types of hand, use it as a comparing dictionary
# How would you modify our original solution to choose the best 5-card hand from a 7-card poker hand?
  # 1 brute idea is:
    # find out all the combinations of 5 cards from the 7
    # use the weight as the comparing criterion
    # find the most weight combination
  # 2 alternative
    # ?
