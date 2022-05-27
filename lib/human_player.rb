class HumanPlayer
  # TODO: DRY this out
  LETTERS = [ 'x', 'o' ]

  attr_accessor :letter

  def initialize(options)
    @letter = options[:letter]
    validate_letter!
  end

  # Human player interface
  def prepare(first_letter)
    puts # Add a line at the top so first message stands out
    welcome_user
    cointoss(first_letter)
  end

  # Player interface
  def take_turn(state)
    move = nil
    move = fetch_move(state) while move.nil?
    return state.apply(move, letter)
  end

  # Human player interface
  def conclude(state)
    if state.winner?
      print_message("#{state.winner.inspect} wins!")
    end
    if !state.available_moves?
      print_message("That's a draw.")
    end
    print_message("Bye for now.")
  end

  private

  def pause
    gets("[any key]")
  end

  # TODO: Move to GameState?
  def validate_letter!
    if !LETTERS.include?(letter)
      raise ArgumentError, "Argument #{letter.inspect} not in: #{LETTERS.inspect}"
    end
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
      Your move. [1-9]

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

  def parse_int(user_input)
    Integer(user_input)
  rescue ArgumentError
    nil
  end

  def fetch_move(state)
    print_board(state)
    user_input = get_user_input
    move = parse_int(user_input)
    if !move 
      print_message("Invalid move #{user_input.inspect} - must be an integer.")
      false
    end

    if !state.in_range?(move)
      print_message("Invalid move #{user_input.inspect} - must be an between 1 and 9.")
      false
    end

    if !state.available?(move)
      print_message("Invalid move #{user_input.inspect} - that space is already occupied.")
      false
    end

    move
  end
end
