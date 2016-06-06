STDOUT.sync = true # DO NOT REMOVE

@road = gets.to_i # the length of the road before the gap.
@gap = gets.to_i # the length of the gap.
@platform = gets.to_i # the length of the landing platform.

def solve(speed, coord_x)
  action = :WAIT
  (speed<@gap+1) && action = :SPEED
  (coord_x+speed == @road+@gap) &&  action = :JUMP
  ( speed>@gap+1 || coord_x>=@road+@gap ) && action = :SLOW
  
  puts action
end


loop do
  speed = gets.to_i
  coord_x = gets.to_i
  solve speed, coord_x
end
