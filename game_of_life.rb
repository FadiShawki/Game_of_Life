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
require './cell'
require './grid'

# Settings
width = 1080
height = 720
grid_width = width / 10
grid_height = height / 10

# Create grid
grid = Grid.new(width, height, grid_width, grid_height)
grid.show
