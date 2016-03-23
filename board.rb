require 'terminal-table'

class Board

  #Creates a board with the X, and Y sizes
  def initialize(x_length = 8, y_length = 8)
    @rows = []
    @header = ["0"]
    x_length.times do |num|
      @header << num+1
    end
    empty_row = Array.new(x_length, " ")
    y_length.times do |num|
      @rows << empty_row.clone.unshift(num+1)
      @rows << :separator unless num == y_length - 1
    end
  end

  #returns a Table object, that if you #puts will print ASCII table
  def table
    Terminal::Table.new :headings => @header, :rows => @rows
  end
end

board = Board.new
puts board.table