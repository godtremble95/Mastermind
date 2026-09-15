require "curses"

# A module for recieving desired color pairs
module Colors
  def self.set_colors
    Curses.init_color(10, 125, 117, 125) # Dark Gray
    Curses.init_color(11, 270, 270, 270) # Light Gray

    Curses.init_pair(1, 0, 1) # Red bkgd
    Curses.init_pair(2, 0, 2) # Greed bkgd
    Curses.init_pair(3, 0, 3) # Yellow bkgd
    Curses.init_pair(4, 0, 4) # Blue bkgd
    Curses.init_pair(5, 0, 5) # Magenta/purple bkgd
    Curses.init_pair(6, 7, 10)  # Dark Gray bkgd w/ White txt
    Curses.init_pair(7, 7, 0)   # Black bkgd w/ White txt
  end

  def self.reset
    get_color 0
  end

  def self.red
    get_color 1
  end

  def self.green
    get_color 2
  end

  def self.yellow
    get_color 3
  end

  def self.blue
    get_color 4
  end

  def self.purple
    get_color 5
  end

  def self.dark_gray
    get_color 6
  end

  def self.black
    get_color 7
  end

  private

  def self.get_color(color_num)
    Curses.color_pair color_num
  end
end