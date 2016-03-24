class Path
  attr_reader :position, :parent
  #A path object may have a parent path object(so we can trace back how we got there)
  #They will have a coordinate.
  def initialize(coordinate=[0,0], parent = nil)
    @position = coordinate
    @parent = parent
  end

  #Returns an array of Path objects that are potential moves.
  def potential_moves
    #Declare the potential array
    potentials = []

    #changes is all of the potential 2 Digit arrays based off this Path objects position
    changes = [[@position[0]+1, @position[1]+2],[@position[0]-1, @position[1]+2],[@position[0]+1, @position[1]-2],[@position[0]-1, @position[1]-2],[@position[0]+2, @position[1]+1],[@position[0]-2, @position[1]+1],[@position[0]+2, @position[1]-1],[@position[0]-2, @position[1]-1]]
    
    #For each of the potential coordinates it can land
    changes.each do |coord|
      begin
      #Create new Path objects pointing to the original as the parent
      #push them onto the potentials array
      potentials << Path.new(coord, self) 
      rescue ArgumentError
        next
      end 
    end
    potentials
  end
end