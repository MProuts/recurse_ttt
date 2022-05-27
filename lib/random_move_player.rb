class RandomMovePlayer
  # TODO: DRY
  LETTERS = [ 'x', 'o' ]

  attr_accessor :letter

  def prepare(opponent_letter)
    self.letter = LETTERS.find { |l| l != opponent_letter }
  end

end
