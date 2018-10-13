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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
p drawn.count { |card| card.rank == 5 } == 4
p drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
p drawn != drawn2 # Almost always.
