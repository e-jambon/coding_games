STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.
# ---
# Hint: You can use the debug stream to print initialTX and initialTY, if Thor seems not follow your orders.

# light_x: the X position of the light of power
# light_y: the Y position of the light of power
# initial_tx: Thor's starting X position
# initial_ty: Thor's starting Y position
@light_x, @light_y, @thor_x, @thor_y = gets.split(" ").collect {|x| x.to_i}

def direction

  dir = String.new 
  
  (dir += 'S') && @thor_y+=1  if @thor_y.between? 0, @light_y-1
  (dir += 'N') && @thor_y-=1  if @thor_y.between? @light_y+1, 17
    
  (dir += 'E') && @thor_x+=1  if @thor_x.between? 0, @light_x-1
  (dir += 'W') && @thor_x-=1  if @thor_x.between? @light_x+1, 39

  dir
end


# game loop
loop do
  remaining_turns = gets.to_i # The remaining amount of turns Thor can move. Do not remove this line.
  puts direction
end

