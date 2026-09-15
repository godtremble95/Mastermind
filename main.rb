require "curses"
require_relative "lib/game"

Curses.init_screen # clears the screen for the game to 'draw'

# Allows for color support and retains terminal's default color pair
Curses.start_color
Curses.use_default_colors
Curses.curs_set 0
begin
  game = Game.new
  game.play
ensure
  # ensures the screen will always revert to before game opened
  Curses.close_screen
end
