class RandomMovePlayer
  # TODO: DRY
  LETTERS = [ 'x', 'o' ]

  attr_accessor :letter

  # Computer player interface
  def prepare(opponent_letter)
    self.letter = LETTERS.find { |l| l != opponent_letter }
  end

  # Player interface
  def take_turn(state)
    move = state.available_moves.sample
    return state.apply(move, letter)
  end

end
