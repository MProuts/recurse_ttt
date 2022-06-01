# Player is an abstract module representing the Player interface
#
# Role: Player
module Player
  attr_accessor :letter

  def take_turn(state)
    raise NotImplementedError, "This #{self.class} cannot respond to `#{__callee__}`"
  end

  private

  def parse_int(user_input)
    Integer(user_input)
  rescue ArgumentError
    nil
  end

  def validate_letter!(letter)
    if letter.length != 1
      msg = "Invalid letter argument #{letter.inspect}. Must be one character long."
      raise ArgumentError, msg
    end
    if int = parse_int(letter)
      msg = "Invalid letter argument #{letter.inspect}. Must not be a number."
      raise ArgumentError, msg
    end
  end

end
