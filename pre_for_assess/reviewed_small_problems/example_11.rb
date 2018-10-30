class Card
  include Comparable
  attr_reader :rank, :suit, :rank_value, :suit_value
  RANK_TABLE = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}
  SUIT_FACTOR = {'Spades' => 4, 'Hearts' => 3, 'Clubs' => 2, 'Diamonds' => 1}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @rank_value = RANK_TABLE.fetch(rank, rank)
    @suit_value = SUIT_FACTOR[suit]
  end

  def <=>(other)
    if rank_value != other.rank_value
      rank_value <=> other.rank_value
    else
      suit_value <=> other.suit_value
    end
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

c1 = Card.new(2, 'Hearts')
c2 = Card.new(10, 'Diamonds')
c3 = Card.new('Ace', 'Clubs')
c4 = Card.new(5, 'Hearts')
c5 = Card.new(10, 'Spades')

puts c1 < c2
puts c2 < c3
puts c3 > c4
puts c4 < c5
puts c5 > c2
