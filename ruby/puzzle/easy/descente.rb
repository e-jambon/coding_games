STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.


# game loop
loop do
    @mountainHeights = Array.new
    
    8.times do
        @mountainHeights << gets.to_i # represents the height of one mountain, from 9 to 0. 
    end
    
    # Write an action using puts
    # To debug: STDERR.puts "Debug messages..."
    
    puts "#{@mountainHeights.index(@mountainHeights.max)}" # The number of the mountain to fire on.
end
