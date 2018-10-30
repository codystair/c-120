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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

deck.draw

p deck.cards.count == 51
drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
