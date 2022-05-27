class TUI

  def initialize(player)
    @player = player
  end

  def welcome_user
    puts # Add a line at the top so first message stands out
    print_message("Welcome to Tic-Tac-Toe!")
    print_message("Your letter is #{player.letter.inspect}.")
    pause
  end

  def cointoss(first_letter)
    print_message("Cointoss...")
    show_spinner
    print_message("#{first_letter.inspect} goes first.")
    pause
  end

  def fetch_move(board_string)
    print_board(board_string)
    print('Your move. [1-9] ---> ')

    get_user_input
  end

  def congratulate_winner(winner, board_string)
    print_board(board_string)
    print_message("#{winner.inspect} wins!")
  end

  def announce_draw
    print_message("That's a draw.")
  end

  def farewell
    print_message("Bye for now.")
  end

  private

  attr_reader :player

  def pause
    puts("[Enter]")
    gets
  end

  # Hat tip:
  # https://rosettacode.org/wiki/Spinning_rod_animation/Text#Ruby
  def show_spinner(seconds = 2)
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

  def print_message(message)
    puts <<~OUTPUT
      #{message.chomp}

    OUTPUT
  end

  def print_board(board_string)
    puts <<~OUTPUT
      #{board_string}

    OUTPUT
  end

  def get_user_input
    user_input = gets.chomp
    puts
    return user_input
  end
end
