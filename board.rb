require 'terminal-table'

class Board

  #Creates a board with the X, and Y sizes
  def initialize(x_length = 8, y_length = 8)
    @rows = [] #Initialize empty rows
    @header = ["0"] #Start with 0 for row #
    x_length.times do |num|
      @header << num+1 #add the numbers as the header for X axis labelling
    end
    empty_row = Array.new(x_length, " ") #Create a basic arrow of empty spaces of size given
    y_length.times do |num|
      @rows << empty_row.clone.unshift(num+1) #Add the row number to front of array(to label y-axis)
      @rows << :separator unless num == y_length - 1 #add a seperator unless it's the last one, which case we don't need one.
    end
  end

  #def test;end

  #Will mark the position with an X
  #Made this function, so I can learn how to navigate, and point at positions using coordinates
  def mark(coordinate)
    raise(ArgumentError, "incorrect input, Must be Array") unless coordinate.is_a? Array
    raise(ArgumentError, "incorrect size, 2 coordinates needed") unless coordinate.size == 2
    if coordinate[0] > @rows.last[0] || coordinate[1] > @header.last
      raise(ArgumentError, "position does not exist")
    end

    if coordinate[0] == 1 #If their first input is 1 (1, y)
      @rows[0][coordinate[1]] = "X" #The first row down, and their second number (position on that row)
    else
      @rows[(coordinate[0]-1) * 2][coordinate[1]] = "X" 
      #if not, then get the row they wanted, by subtracting 1, and then multiplying by 2, 
      #because we have to account for :separators in the @rows array, then their second number(position)  
    end
    "Marked!"
  end

  #returns a Table object, that if you #puts will print ASCII table
  def table
    Terminal::Table.new :headings => @header, :rows => @rows
  end
end