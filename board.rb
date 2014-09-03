require './piece'
require './illegal_move_error'

class Board
  attr_reader :size, :pieces
  
  def initialize
    @size = 8
    @pieces = initial_white + initial_black
  end
  
  def move_piece(x1, y1, x2, y2)
    unless piece = find_piece(x1, y1)
      raise IllegalMoveError
    end
    piece.move(x2, y2)
  end
  
  def show
    (8.downto 1).each do |row|
      print '|'
      (1..8).each do |column|
        piece = find_piece(column, row)
        if piece && piece.color == :white
          print piece.king ? 'W' : 'w'
        elsif piece
          print piece.king ? 'B' : 'b'
        else
          print '_'
        end
        print '|'
      end
      puts
    end
  end
  
  def find_piece(x, y)
    @pieces.select { |p| p.x == x && p.y == y }.first
  end
  
  private
  
  def initial_white
    coordinates = [[1, 1], [3, 1], [5, 1], [7, 1],
                   [2, 2], [4, 2], [6, 2], [8, 2],
                   [1, 3], [3, 3], [5, 3], [7, 3]]
    coordinates.map { |x, y| Piece.new(self, :white, x, y) }
  end
  
  def initial_black
    coordinates = [[2, 8], [4, 8], [6, 8], [8, 8],
                   [1, 7], [3, 7], [5, 7], [7, 7],
                   [2, 6], [4, 6], [6, 6], [8, 6]]
    coordinates.map { |x, y| Piece.new(self, :black, x, y) }
  end
end
