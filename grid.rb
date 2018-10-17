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
require 'gosu'

class Grid < Gosu::Window
  attr_reader :grid_width, :grid_height, :cells

  def initialize(width = 1080, height = 720, grid_width = 50, grid_height = 50)
    super width, height
    self.caption = 'Game of Life'

    @grid_width = grid_width
    @grid_height = grid_height

    # Create cell and buffer grid
    @cells = Array.new(@grid_width) { Array.new(@grid_height) }
    @buffered_cells = Array.new(@grid_width) { Array.new(@grid_height) }

    # Instantiate cells and buffer
    @grid_width.times do |x|
      @grid_height.times do |y|
        alive_on_initiate = alive_on_initiate(x, y)
        @cells[x][y] = Cell.new(x, y, alive_on_initiate)
        @buffered_cells[x][y] = Cell.new(x, y, alive_on_initiate)
      end
    end
  end

  # Check whether or not a new cell should be alive or not, override this method to change starting values.
  def alive_on_initiate(x, y)
    [true, false].sample
  end

  def update
    # Apply all cell changes to buffer
    @grid_width.times do |x|
      @grid_height.times do |y|
        cell = @cells[x][y]
        adjacent_count = living_adjacent_count(cell)

        buffered_cell = @buffered_cells[x][y]
        if cell.alive
          # Any live cell with fewer than two live neighbors dies, as if by underpopulation.
          if adjacent_count < 2
            buffered_cell.underpopulation
          # Any live cell with more than three live neighbors dies, as if by overpopulation.
          elsif adjacent_count > 3
            buffered_cell.overpopulation
          # Any live cell with two or three live neighbors lives on to the next generation.
          else
            buffered_cell.survive
          end

          next
        end

        # Any dead cell with exactly three live neighbors becomes a live cell, as if by reproduction.
        buffered_cell.reproduction if adjacent_count == 3
      end
    end

    # Swap buffer with current cells
    @grid_width.times do |x|
      @grid_height.times do |y|
        @cells[x][y].buffer(@buffered_cells[x][y])
      end
    end
  end

  def draw
    cell_width = width / @grid_width
    cell_height = height / @grid_height

    @grid_width.times do |x|
      @grid_height.times do |y|
        cell = @cells[x][y]

        draw_rect(x * cell_width, y * cell_height, cell_width, cell_height, (cell.alive ? Gosu::Color::WHITE : Gosu::Color::BLACK), 0)
      end
    end
  end

  def living_adjacent_count(cell)
    count = 0

    # 000
    # 0X0
    # 000

    -1.upto(1) do |x_off|
      -1.upto(1) do |y_off|
        # Current cell is not an adjacent cell
        next if x_off == 0 && y_off == 0

        adjacent = cell(@cells, cell.x + x_off, cell.y + y_off)

        # No cell here, move on
        next if adjacent.nil?

        count += (adjacent.alive ? 1 : 0)
      end
    end

    count
  end

  def cell(cells, x, y)
    # Outside of grid
    return nil if x < 0 || x >= @grid_width || y < 0 || y >= @grid_height

    cells[x][y]
  end

  # Encapsulation
  private :living_adjacent_count, :cell
end
