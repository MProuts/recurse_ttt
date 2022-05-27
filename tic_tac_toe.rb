# Require everything in lib/
Dir["./lib/*.rb"].each {|file| require file }

# Responsible for orchestrating between players and state
#
# Roles: Playable
class TicTacToe
  attr_reader :state, :human, :computer

  def initialize(options)
    @state = GameState.new()
    @human    = options[:human]
    @computer = options[:computer]

    # private
    @_turn_enumerator = [ @human, @computer ].shuffle.cycle
  end

  def play
    # Need to prepare computer first so it's letter is set
    # TODO: more robust way to enforce this order
    computer.prepare(human.letter)
    human.prepare(peek_next_player.letter)
    while !state.winner
      self.state = next_player.take_turn(state)
    end
    human.conclude(state.winner)
  end

  def play_turn
    next_player.take_turn(self)
  end

  private

  attr_writer :state, :human, :computer

  def peek_next_player
    @_turn_enumerator.peek
  end

  def next_player
    @_turn_enumerator.next
  end

end

ttt = TicTacToe.new(
  human: HumanPlayer.new(letter: 'x'),
  computer: RandomMovePlayer.new,
)

ttt.play
