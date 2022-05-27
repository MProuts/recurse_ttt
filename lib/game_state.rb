# Represents a tic-tac-toe game at a moment in time between turns. The numbers
# 1-9 represent blank spaces on a board numbered as follows:
#
# 1 2 3
# 4 5 6
# 7 8 9
#
# As moves are taken, the numbers are replaced with x's and o's. After two turns
# the board might look like this:
#
# 1 2 x
# 3 4 5
# 6 7 o
#
class GameState
  # TODO: DRY this out
  LETTERS = [ 'x', 'o' ]
  POSITIONS = (1..9)
  WINDEXES = [
    # Rows
    [ 0, 1, 2 ],
    [ 3, 4, 5 ],
    [ 6, 7, 8 ],
    # Columns
    [ 0, 3, 6 ],
    [ 1, 4, 7 ],
    [ 2, 5, 8 ],
    # Diagonals
    [ 0, 4, 8 ],
    [ 2, 4, 6 ],
  ]

  attr_accessor :board

  def initialize()
    @board = POSITIONS.to_a
  end

  def rows
    board.each_slice(3)
  end

  def board_string
    rows = board.each_slice(3).map { |row| row.join(" ") }
    rows.join("\n")
  end

  def in_range?(move)
    POSITIONS.include?(move)
  end

  def available_moves
    board.select { |move| move.is_a? Integer }
  end

  def available?(move)
    available_moves.include?(move)
  end

  def apply(move, letter)
    next_state = self.dup
    index = move - 1
    next_state.board[index] = letter
    next_state
  end

  def wins
    WINDEXES.map do |indexes|
      board.values_at(*indexes)
    end
  end

  def winner
    win = wins.find { |win| win.uniq.size == 1 }
    win && win.first
  end

  private

  def dup
    self.class.new.tap do |state|
      state.board = board.dup
    end
  end

  # TODO: add letter as parameter?
  #
  # @param move [Integer] number representing space to fill on board
  # @return [GameState] new state with move applied
  # def apply_move(move)
  # end
end
