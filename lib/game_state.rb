# GameState represents a tic-tac-toe game at a moment in time between turns. The
# numbers 1-9 represent blank spaces on a board numbered as follows:
#
# 1 2 3
# 4 5 6
# 7 8 9
#
# As moves are taken, the numbers are replaced with the players' respective
# letters. After two turns the board might look like this:
#
# 1 2 X
# 3 4 5
# 6 7 Ø
class GameState
  POSITIONS = (1..9)
  # Winning indexes (not to be confused with window spray)
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

  def move_error(move)
    if !move 
      return "must be an integer"
    end
    if !in_range?(move)
      return "must be an between 1 and 9"
    end
    if !available?(move)
      return "that space is already occupied"
    end
  end

  def in_range?(move)
    POSITIONS.include?(move)
  end

  def available?(move)
    available_moves.include?(move)
  end

  def available_moves
    board.select { |move| move.is_a? Integer }
  end

  def available_moves?
    !available_moves.empty?
  end

  def apply(move, letter)
    next_state = self.dup
    index = move - 1
    next_state.board[index] = letter
    next_state
  end

  def possible_wins
    WINDEXES.map do |indexes|
      board.values_at(*indexes)
    end
  end

  def winner
    win = possible_wins.find { |win| win.uniq.size == 1 }
    win && win.first
  end

  def winner?
    !winner.nil?
  end

  protected

  attr_accessor :board

  private

  def dup
    self.class.new.tap do |state|
      state.board = board.dup
    end
  end

end
