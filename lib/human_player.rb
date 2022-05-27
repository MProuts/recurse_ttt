require 'player'

# Responsible for coordinating between UI and game state
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
    while move.nil?
      user_input = ui.fetch_move(state.board_string)
      parsed_move = parse_int(user_input)

      if error = state.move_error(parsed_move)
        full_message = "Invalid move #{user_input.inspect} - #{error}."
        ui.show_error(full_message)
        next
      end
      move = parsed_move
    end

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

end
