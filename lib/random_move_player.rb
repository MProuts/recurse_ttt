require 'player'

# RandomMovePlayer is a computer player that takes random moves.
#
# Role: Player
class RandomMovePlayer
  include Player

  def take_turn(state)
    move = state.available_moves.sample
    return state.apply(move, letter)
  end

end
