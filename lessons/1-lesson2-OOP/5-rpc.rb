# Rock, Paper, Scissors is a two-player game where each player chooses one of three
# possible moves: rock, paper, scissors. The chosen moves will then be compared to
# see who wins, according to the following rules:
#
# - rock beats scissors
# - scissors beats paper
# - paper beats rock
#
# I the player chose the same move, then it's a tie.

# Nouns: player, move, rule
# Verbs: choose, compare

# Player
#  - choose
# Move
# Rule
#
# - compare


class Player
  def initialize
  end

  def choose

  end
end

class Move
  def initialize
  end
end

class Rule
  def initialize
  end
end

def compare(move1, move2)
end

# RPSGame.new.play

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human_choose_move
    computer_choose_move
    display_winner
    display_goodbye_message
  end
end


# is this design, with Human and Computer sub-classes, better? Why, or why not?
  # For me, it's hard to say. The differentiation between human and computer is actaully not obvious
  # But this is just a small case, maybe in large case, this way of extracting would have more obvious advantages
# what is the primary improvement of this new design?
  # It's more friendly for human reading, easier to understand from the `class RPSGame`
  # but the extraction in this video doesn't make other parts of the program more readable.
  # Because the tradeoff for readability in `class RPSGame` is the increasing relationships produced among more classes
# what is the primary drawback of this new design?
  # I said above.


# Compare this design with the one in the previous assignment:(add class Move)
# what is the primary improvement of this new design?
# what is the primary drawback of this new design?

# Methods look more concise
# Too many abstractions, it's not worthy for a program to trade litter readability with a lot additional abstraction
# This will lead some long method chain.
# Normal human can only hold about 3-4 chunks of information in their working memory,
# oversized information structure would overwhelm human brain.
