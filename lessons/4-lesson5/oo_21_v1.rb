class Player
  attr_reader :species, :name, :cards_in_hand
end

class Game
  attr_reader :human, :npc, :cards_pool

  def initialize
    # hit every player 2 cards
  end

  def play_a_round
    # hit and show initial cards
    #loop
      # human's turn
        # hit or stay
          # hit: break busted?
          # stay: # npc's turn
            # hit or stay
              # hit: break busted?
              # stay:
                # finnal comparing if human also chose stay
                # no one busted, back to the top of the loop
    # loop end
  end

  def deal_to(player)
  end

  def busted?(player)
  end

end

class Deck
  attr_reader :cards

end
