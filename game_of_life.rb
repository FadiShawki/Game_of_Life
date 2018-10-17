#
#    ____                               __   _     _  __
#   / ___| __ _ _ __ ___   ___    ___  / _| | |   (_)/ _| ___
#  | |  _ / _` | '_ ` _ \ / _ \  / _ \| |_  | |   | | |_ / _ \
#  | |_| | (_| | | | | | |  __/ | (_) |  _| | |___| |  _|  __/
#   \____|\__,_|_| |_| |_|\___|  \___/|_|   |_____|_|_|  \___|
#
# - Executable from command line
# - Use OOP
# - Conway's Game of Life
#   - Any live cell with fewer than two live neighbors dies, as if by underpopulation.
#   - Any live cell with two or three live neighbors lives on to the next generation.
#   - Any live cell with more than three live neighbors dies, as if by overpopulation.
#   - Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
#
# @author Fadi Shawki - 2018
#
require 'rubygems'
require 'bundler/setup'
require './cell'
require './grid'

# Methods
def get_grid(width, height, grid_width, grid_height)
  puts '   ____                               __   _     _  __'
  puts '  / ___| __ _ _ __ ___   ___    ___  / _| | |   (_)/ _| ___'
  puts ' | |  _ / _` | \'_ ` _ \ / _ \  / _ \| |_  | |   | | |_ / _ \\'
  puts ' | |_| | (_| | | | | | |  __/ | (_) |  _| | |___| |  _|  __/'
  puts '  \____|\__,_|_| |_| |_|\___|  \___/|_|   |_____|_|_|  \___|'
  puts '  Created by Fadi Shawki'
  puts ''
  puts 'Enter number to open Grid'
  puts '  1. Default'
  puts '  2. Cylinder'
  puts '  3. Torus'

  case gets.chomp
  when "1"
    puts 'Opening Default Grid...'
    return Grid.new(width, height, grid_width, grid_height)
  when "2"
    puts 'Opening Cylinder Grid...'
    return CylinderGrid.new(width, height, grid_width, grid_height)
  when "3"
    puts 'Opening Torus Grid...'
    return TorusGrid.new(width, height, grid_width, grid_height)
  else
    puts 'Invalid Grid number'
    return get_grid(width, height, grid_width, grid_height)
  end
end

# Settings
width = 1080
height = 720
grid_width = width / 10
grid_height = height / 10

# Create grid
grid = get_grid(width, height, grid_width, grid_height)
grid.show