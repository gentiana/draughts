require './board'

class Draughts
  def initialize
    @board = Board.new
  end
  
  def play
    while true
      @board.show
      cmd = gets.strip
      break if cmd == 'q' || cmd == 'quit'
      begin
        make_move(cmd)
      rescue IllegalMoveError => e
        puts e.message
      rescue ArgumentError
        print_help
      end
    end
  end
  
  private
  
  def make_move(cmd)
    coordinates = cmd.split
    if ['c', 'capture'].include? coordinates.first
      coordinates.shift
      coordinates.map! { |s| s.to_i }
      @board.capture(*coordinates)
    else
      coordinates.map! { |s| s.to_i }
      @board.move_piece(*coordinates)
    end
  end
  
  def print_help
    puts "Write four numbers to move a piece, preceded with 'c' or 'capture' if capture.",
         "Examples:",
         "To move from (1,3) to (2,4)",
         "1 3 2 4",
         "To make capture from (1,5) to (3,3)",
         "c 1 5 3 3",
         "Write 'q' or 'quit' to quit."
  end
end
