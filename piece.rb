require './illegal_move_error'

class Piece
  attr_reader :color, :king, :x, :y
  
  def initialize(board, color, x, y)
    if [:white, :black].include? color
      @color = color
    else
      raise ArgumentError, "Color must be :black or :white"
    end
    
    @board = board
    
    if in_board(x, y)
      @x = x
      @y = y
    else
      raise ArgumentError, "Coordinates must be in range 1..#{@board.size}"
    end
    
    @king = false
  end
  
  def move(x, y)
    if legal(x, y)
      @x = x
      @y = y
    else
      raise IllegalMoveError
    end
  end
  
  def to_s
    letters = '_abcdefgh'
    "#{@color}, #{letters[@x]}#{@y}#{', king' if @king}"
  end
  
  private
  
  def legal(x, y)
    # TODO czy jego kolej
    in_board(x, y) && empty(x, y) && if @king
      diagonal(x, y)
    else
      adjacent(x, y)
    end
  end
  
  def in_board(x, y)
    x >= 1 && y >= 1 && x <= @board.size && y <= @board.size
  end
  
  def empty(x, y)
    !@board.find_piece(x, y)
  end
  
  def adjacent(x, y)
    [1, -1].include?(x - @x) && if @color == :white
      y == @y + 1
    else
      y == @y - 1
    end
  end
  
  def diagonal(x, y)
    ((@x - x) == (@y - y)) && ((@x - x) == -(@y - y))
  end
end
