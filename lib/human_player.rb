require_relative './player'

class HumanPlayer
  include Player

  def prepare(first_letter)
    puts # Adds a line at the top so first message stands out
    welcome_user
    pause
    cointoss(first_letter)
    pause
  end

  def take_turn(state)
    move = nil
    move = fetch_move(state) while move.nil?
    return state.apply(move, letter)
  end

  def conclude(state)
    if state.winner?
      print_board(state)
      print_message("#{state.winner.inspect} wins!")
    end
    if !state.available_moves?
      print_message("That's a draw.")
    end
    print_message("Bye for now.")
  end

  private

  def pause
    puts("[Enter]")
    gets
  end

  def welcome_user
    print_message("Welcome to Tic-Tac-Toe!")
    print_message("Your letter is #{letter.inspect}.")
  end

  def cointoss(first_letter)
    print_message("Cointoss...")
    print_spinner
    print_message("#{first_letter.inspect} goes first.")
  end

  # Hat tip: https://rosettacode.org/wiki/Spinning_rod_animation/Text#Ruby
  def print_spinner(seconds = 2)
    begin
      printf("\033[?25l") # Hide cursor
      seconds.times do
        %w[| / - \\].each do |rod|
          print rod
          sleep 0.25
          print "\b"
        end
      end
    ensure
      printf("\033[?25h") # Restore cursor
    end
  end

  def print_board(state)
    puts <<~OUTPUT
      #{state.board_string}

    OUTPUT
  end

  def get_user_input
    user_input = gets.chomp
    puts
    return user_input
  end

  def print_message(message)
    puts <<~OUTPUT
      #{message.chomp}

    OUTPUT
  end

  def prompt_message(message)
    puts message
  end

  # add optional block to state methods
  def fetch_move(state)
    print_board(state)
    print('Your move. [1-9] ---> ')

    user_input = get_user_input
    move = parse_int(user_input)
    if !move 
      print_message("Invalid move #{user_input.inspect} - must be an integer.")
      return
    end

    if !state.in_range?(move)
      print_message("Invalid move #{user_input.inspect} - must be an between 1 and 9.")
      return
    end

    if !state.available?(move)
      print_message("Invalid move #{user_input.inspect} - that space is already occupied.")
      return
    end

    move
  end
end
