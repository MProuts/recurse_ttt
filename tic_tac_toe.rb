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
    human.prepare
    computer.prepare(human.letter)
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

  def next_player
    human
    # @_turn_enumerator.next
  end

  private

  def debug(str)
    if ENV['DEBUG'] == 'true'
      puts "#{str}: #{instance_eval(str).inspect}"
    end
  end

end

ttt = TicTacToe.new(
  human: HumanPlayer.new(letter: 'x'),
  computer: RandomMovePlayer.new,
)

ttt.play
