class HumanPlayer
  # TODO: DRY this out
  LETTERS = [ 'x', 'o' ]

  attr_accessor :letter

  def initialize(options)
    @letter = options[:letter]
    validate_letter!
  end

  def prepare
    welcome_user
  end

  def welcome_user
    puts
    print_message("Welcome to Tic-Tac-Toe!")
    print_message("Your letter is '#{@letter}'.")
  end
  
  def take_turn(state)
    move = nil
    move = fetch_move(state) while move.nil?
    return state.apply(move, letter)
  end

  def conclude(winner)
    print_message("#{winner} wins!")
  end

  private

  def validate_letter!
    if !LETTERS.include?(letter)
      raise ArgumentError, "Argument #{letter.inspect} not in: #{LETTERS.inspect}"
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
