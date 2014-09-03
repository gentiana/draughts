class IllegalMoveError < StandardError
  def initialize(msg = "Illegal move, do something else")
    super
  end
end
