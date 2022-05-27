require 'player'

class RandomMovePlayer
  include Player

  def initialize(options)
    @letter = options[:letter]
    validate_letter!(@letter)
  end

  def take_turn(state)
    move = state.available_moves.sample
    return state.apply(move, letter)
  end

end
