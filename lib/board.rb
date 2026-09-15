require "curses"
require_relative "board/colors"

class Board
  # include Curses
  include Colors
  
  attr_reader :boundary
  BOARDER_COUNT = 2
  PEG_LENGTH = 4

  def initialize(num_trys, num_options, num_colors)
    @num_trys = num_trys
    @num_options = num_options
    @num_colors = num_colors
    @total_length = (@num_trys * PEG_LENGTH) + PEG_LENGTH + BOARDER_COUNT
    @board_hight = @num_options + BOARDER_COUNT + (@num_options / PEG_LENGTH).ceil + 1
    
    Colors.set_colors
    @boundary = Curses::Window.new(@board_hight + @num_colors + 1, @total_length, 3, (Curses.cols - @total_length) / 2)
    @board = @boundary.derwin(@board_hight, @boundary.maxx - BOARDER_COUNT, 0, 1)
    # TODO: sub window for picking colors
    @boundary.box # temp
  end

  def start
    draw_boundary
    draw_board
    @boundary.refresh
  end

  private

  # draws the left & right boarder of the 'peg' board
  def draw_boundary
    cols = [0, @boundary.maxx- 1]
    for col in cols do
      @boundary.setpos(1, col)
      @boundary.cury.upto (@num_options + BOARDER_COUNT) do |row|
        @boundary.setpos(row, col)
        if @boundary.cury == 1
          str = "\u2554" if @boundary.curx == cols[0]   # top-left corner
          str = "\u2557" if @boundary.curx == cols[1]   # top-right corner
        elsif @boundary.cury  == (@num_options + BOARDER_COUNT)
          str = "\u255A" if @boundary.curx == cols[0]   # bottom-left corner
          str = "\u255D" if @boundary.curx == cols[1]   # bottom-right corner
        else
          str = "\u2551"  # all non-corners
        end
        @boundary << str
      end
    end
    #@boundary.refresh
  end

  # initial draws of the 'peg' board 
  def draw_board
    @board_hight.times do |row|
      (@board.maxx / PEG_LENGTH).times do |col|
        @board.setpos(row, col * PEG_LENGTH)
        @board.attrset Colors.dark_gray if col.even?
        @board.attrset Colors.black if col == (@board.maxx / PEG_LENGTH) -1
        case row
        when 0  # top row list try number exept for the end
          str = col != (@board.maxx / PEG_LENGTH) - 1 ? sprintf(" %2.2d ", col + 1) : "CODE"
        when 1, (@num_options + BOARDER_COUNT)  # horizontal boarder for the 'peg' board
          str = "\u2550\u2550\u2550\u2550"
        when 2..((@num_options + BOARDER_COUNT) - 1)  # play area of the 'peg' board blank exept for the end
          str = col != (@board.maxx / PEG_LENGTH) - 1 ? "    " : " ?? "
        else
          str = "    "
        end
        @board << str
        @board.attrset Colors.reset
      end
    end
    #@board.noutrefresh
  end
end
