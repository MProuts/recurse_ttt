require 'test_helper'

class SmartPlayerTest < Minitest::Test

  class StateDouble
    def initialize(board)
      @board = board
    end

    def available_moves
      @board.select { |move| move.is_a? Integer }
    end
  end

  describe "#move" do
    before do
      @player = SmartPlayer.new(letter: 'X')
    end

    wins = <<~TEXT
      Win: If the player has two in a row, it places a third to get three
      in a row.
    TEXT

    it wins do
      state = GameState.new([
        'X', 'X',  2,
         3,  'Ø',  5,
         6,   7,  'Ø',
      ])

      @player.move(state).must_equal(2)
    end

    blocks = <<~TEXT
      Block: If the opponent has two in a row, the player must play the third
      themselves to block the opponent.
    TEXT
    it blocks do
    end

    forks = <<~TEXT
      Fork: Cause a scenario where the player has two ways to win (two non-blocked
      lines of 2).
    TEXT
    it forks do
    end

    blocks_forks = <<~TEXT
      Blocking an opponent's fork: If there is only one possible fork for the
      opponent, the player should block it. Otherwise, the player should block all
      forks in any way that simultaneously allows them to make two in a row.
      Otherwise, the player should make a two in a row to force the opponent into
      defending, as long as it does not result in them producing a fork. For example,
      if "X" has two opposite corners and "O" has the center, "O" must not play a
      corner move to win. (Playing a corner move in this scenario produces a fork for
      "X" to win.)
    TEXT
    it blocks_forks do
    end

    plays_center = <<~TEXT
      Center: A player marks the center. (If it is the first move of the game,
      playing a corner move gives the second player more opportunities to make a
      mistake and may therefore be the better choice; however, it makes no difference
      between perfect players.)
    TEXT
    it plays_center do
    end

    plays_opposite_corner = <<~TEXT
      Opposite corner: If the opponent is in the corner, the player plays the
      opposite corner.
    TEXT
    it plays_opposite_corner do
    end

    plays_empty_corner = <<~TEXT
      Empty corner: The player plays in a corner square.
    TEXT
    it plays_empty_corner do
    end

    plays_empty_side = <<~TEXT
      Empty side: The player plays in a middle square on any of the four sides.
    TEXT
    it plays_empty_side do
    end
  end

end
