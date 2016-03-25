require 'terminal-table'
require_relative 'path.rb'

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

  def knight_moves(depart, arrive)
    check_coord(depart) #Check both to make sure they're valid
    check_coord(arrive)
    initial_position = Path.new(depart) #make an object of it

    queue = [initial_position] #Create a queue of places to check
    until queue.empty? #until we run out of things to check
      current = queue.shift #Grab the first one, and delete it from the queue

      if current.position == arrive #If it's the location we want to go to
        return current.backtrace #Return an array of positions we jumped to get there
      else #If this position isn't the solution
        potentials = current.potential_moves #Create an array of places to go from here

        potentials.each do |path| #Check that array
          begin
            check_coord(path.position) #Make sure all positions exist on the board
          rescue ArgumentError => e #If they are not valid coordinates
            potentials -= [path] #delete it from the list of potential positions
          end
        end

        queue += potentials #Then add the cleaned list of potential places to jump to, to the list.
      end
    end
  end

  #Will mark the position with an X
  #Made this function, so I can learn how to navigate, and point at positions using coordinates
  def mark(coordinate, char = "X")
    check_coord(coordinate)

    if coordinate[0] == 1 #If their first input is 1 (1, y)
      @rows[0][coordinate[1]] = char #The first row down, and their second number (position on that row)
    else
      @rows[(coordinate[0]-1) * 2][coordinate[1]] = char
      #if not, then get the row they wanted, by subtracting 1, and then multiplying by 2, 
      #because we have to account for :separators in the @rows array, then their second number(position)  
    end
    "Marked!"
  end

  def display
    puts table()
  end

  #returns a Table object, that if you #puts will print ASCII table
  private
  def table
    Terminal::Table.new :headings => @header, :rows => @rows
  end

  #Will return true if the position exists
  def pos_exists?(coordinate)
    return false if coordinate[0] > @rows.last[0] || coordinate[1] > @header.last
    true
  end

  #Will raise an error if the input is not sufficient
  def check_coord(coordinate)
    raise(ArgumentError, "incorrect input, Must be Array") unless coordinate.is_a? Array
    raise(ArgumentError, "incorrect size, 2 coordinates needed") unless coordinate.size == 2
    raise(ArgumentError, "position does not exist") unless pos_exists?(coordinate)
  end
end