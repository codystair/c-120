require 'pry'
class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze
  attr_reader :cards

  def initialize
    reset_cards
  end

  def draw
    reset_cards if cards.empty?
    cards.pop
  end

  private

  def reset_cards
    @cards = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end
    cards.shuffle!
  end

end

class Card
  include Comparable
  attr_reader :rank, :suit, :value
  RANK_TABLE = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = RANK_TABLE.fetch(rank, rank)
  end

  def <=>(other)
    value <=> other.value
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class PokerHand
  attr_reader :cards_in_hand, :cards_count

  def initialize(deck)
    @cards_in_hand = []
    5.times { @cards_in_hand << deck.draw }
    @cards_in_hand.sort_by! { |card| card.value }
    @cards_count = count_cards
  end

  def count_cards
    counts = Hash.new(0)
    ranks = cards_in_hand.map { |card| card.rank }
    ranks.each { |rank| counts[rank] += 1 }
    counts
  end

  def print
    cards_in_hand.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when two_pair?        then 'Two pair'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    straight_flush? && cards_in_hand.first.value == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    n_of_a_kind?(4)
  end

  def full_house?
    n_of_a_kind?(3) && n_of_a_kind?(2)
  end

  def flush?
    cards_in_hand.map { |card| card.suit }.uniq.size == 1
  end

  def straight?
    first_rank = cards_in_hand.first.value
    cards_in_hand.each.with_index(first_rank) do |card, should_be|
      return false if card.value != should_be
    end
    true
  end

  def three_of_a_kind?
    n_of_a_kind?(3)
  end

  def two_pair?
    cards_count.values.count(2) == 2
  end

  def pair?
    n_of_a_kind?(2)
  end

  def n_of_a_kind?(n)
    cards_count.values.one? { |v| v == n }
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

# Danger danger danger: monkey
# patching for testing purposes.
class Array
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

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

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

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
