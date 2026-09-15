require_relative "board"
require_relative "player"

class Game
  # include Curses
  # extend Board
  
  NUM_TRYS = 12
  NUM_COLORS = 6
  CODE_LENGTH = 4

  def initialize
    @board = Board.new(NUM_TRYS, CODE_LENGTH, NUM_COLORS)
    
  end

  def play
    @board.start
    @board.boundary.getch
  end
end
