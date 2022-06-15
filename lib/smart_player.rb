require 'player'

# RandomMovePlayer is a computer player that takes moves based on Newell and
# Simon's algorithm.
#
# Further reading: https://en.wikipedia.org/wiki/Tic-tac-toe#Strategy
#
# Role: Player
class SmartPlayer
  include Player

  def take_turn(state)
    # move = state.available_moves.sample
    # return state.apply(move, letter)
  end

end
