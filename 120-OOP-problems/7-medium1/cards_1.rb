require 'pry'
# Spades > Hearts > Clubs > Diamonds
  # if values are not equal then just compare the value
  # if values are the same then compare the suits

class Card
  include Comparable
  attr_accessor :rank, :suit

  SUIT_VALUES = { 'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1 }
  RANK_VALUES = { 'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14 }

  def initialize(rank, suit)
    self.rank = rank
    self.suit = suit
  end

  def rank_value
    RANK_VALUES[rank] || rank
  end

  def suit_value
    SUIT_VALUES[suit]
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(another)
    if rank_value != another.rank_value
      rank_value <=> another.rank_value
    else
      suit_value <=> another.suit_value
    end
  end
end

cards = [Card.new(7, 'Diamonds'),
         Card.new('Jack', 'Diamonds'),
         Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max == Card.new('Jack', 'Spades')

cards = [Card.new(8, 'Diamonds'),
         Card.new(8, 'Clubs'),
         Card.new(8, 'Spades')]
puts cards.min == cards[0]
puts cards.max == cards[2]
