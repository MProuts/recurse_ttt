require 'player'
require 'pry'

# RandomMovePlayer is a computer player that takes moves based on Newell and
# Simon's algorithm.
#
# Further reading: https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy
#
# Role: Player
class SmartPlayer
  include Player

  def move(state)
    # 1) WIN
    # ======
    # Look for lines with two of our letter and an empty space

    # 2) BLOCK
    # ========
    # Look for lines with two of opponent's letter and an empty space

    # ...

    # TODO: Remove this line!
    # =======================
    #
    # This is just here so we can play against the computer while this method is
    # in progress. It should be removed when this method is complete. We turn it
    # off conditionally so we don't get non-deterministic behavior during
    # tests.
    if !(ENV['APPLICATION_ENV'] == 'test')
      state.available_moves.sample
    end
  end

  def take_turn(state)
    move = move(state)
    return state.apply(move, letter)
  end

end
