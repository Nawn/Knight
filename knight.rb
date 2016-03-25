require_relative 'board.rb'

def coord_input #Will ask for input, and set it to [x, y] coordinates
  input = gets.chomp
  exit if input.downcase == "exit"
  input.gsub(/\s+/, "").split(",").map { |e| e.to_i }
end

done_playing = false

  puts "Thanks for checking out our Knight Pathfinder algorithm!"
  puts "Anything to continue, 'exit' to exit the game!"
  exit if gets.chomp.downcase == "exit"

until done_playing
  board = Board.new

  trail = []

  begin
    board.display

    puts "Please enter the first coordinate! (Example input: 1, 5; or: 2,6)"
    first_coord = coord_input

    puts "Now enter the destination coordinate! (In a 'number, number' format as well!)"
    second_coord = coord_input

    trail = board.knight_moves(first_coord, second_coord)
  rescue ArgumentError => e
    puts "Error!: #{e}"
    retry
  else
    output = "You made it in #{trail.size - 1} steps! Those steps were:"

    trail.each_with_index do |position, index|
      board.mark(position, index+1)
      output << "\n#{index+1}: #{position}"
    end

    board.display
    puts output
  end

  puts "Again!? Anything to continue, No to exit"
  response = gets.chomp.downcase
  done_playing = true if response == "no" || response == "n" || response == "exit"
end