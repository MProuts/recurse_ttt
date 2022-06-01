require 'player'

# A HumanPlayer coordinates between the UI and game state. It instructs the UI
# to print messages based on game lifecycle, parses and validates user input,
# and applies valid moves to the game.
#
# Role: Player
class HumanPlayer
  include Player

  def initialize(options)
    @letter = options[:letter]
    @ui     = options[:ui_class].new(self)
    validate_letter!(@letter)
  end

  def prepare(first_letter)
    ui.welcome_user
    ui.cointoss(first_letter)
  end

  def take_turn(state)
    move = nil
    move = fetch_move(state) while move.nil?

    updated_state = state.apply(move, letter)
    ui.show_move(updated_state.board_string)
    return updated_state
  end

  def conclude(state)
    if state.winner?
      ui.congratulate_winner(state.winner, state.board_string)
    elsif !state.available_moves?
      ui.announce_draw
    end
    ui.farewell
  end

  private

  attr_reader :ui

  def fetch_move(state)
    user_input = ui.fetch_move(state.board_string)
    parsed_move = parse_int(user_input)
    if error = state.move_error(parsed_move)
      full_message = "Invalid move #{user_input.inspect} - #{error}."
      ui.show_error(full_message)
      return
    end
    parsed_move
  end

end
