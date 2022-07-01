$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'player'
require 'human_player'
require 'smart_player'
require 'random_move_player'
require 'game_state'
require 'tui'

# TicTacToe is the main application class. It's responsible for kicking things
# off and coordinating between players and state.
class TicTacToe
  attr_reader :state, :human, :computer

  def initialize(options)
    @human    = options[:human]
    @computer = options[:computer]
    validate_players!
    @state = GameState.new()

    # private
    @_turn_enumerator = [ @human, @computer ].shuffle.cycle
  end

  def play
    first_letter = peek_next_player.letter
    human.prepare(first_letter)
    while !state.winner && state.available_moves?
      self.state = next_player.take_turn(state)
    end
    human.conclude(state)
  end

  private

  attr_writer :state, :human, :computer

  def validate_players!
    if @human.letter == @computer.letter
      raise ArgumentError, "Players must have different letters"
    end
  end

  def peek_next_player
    @_turn_enumerator.peek
  end

  def next_player
    @_turn_enumerator.next
  end

end

ttt = TicTacToe.new(
  human: HumanPlayer.new(
    letter: 'X',
    opponent_letter: 'Ø',
    ui_class: TUI,
  ),
  computer: SmartPlayer.new(
    letter: 'Ø',
    opponent_letter: 'X',
  ),
)

ttt.play
