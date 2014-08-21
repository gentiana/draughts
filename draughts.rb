require './board'

class Draughts
  def initialize
    @board = Board.new
  end
  
  def play
    while true
      @board.show
      cmd = gets.strip
      break if cmd == 'q'
      begin
        make_move(cmd)
      rescue IllegalMoveError
        puts "Illegal move, do something else"
      rescue ArgumentError
        puts "Write four numbers to move piece"
      end
    end
  end
  
  private
  
  def make_move(cmd)
    coordinates = cmd.split.map { |s| s.to_i }
    @board.move_piece(*coordinates)
  end
end
