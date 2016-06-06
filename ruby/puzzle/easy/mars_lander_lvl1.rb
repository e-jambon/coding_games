STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

MaxLandingSpeed = 40
@surface_n = gets.to_i # the number of points used to draw the surface of Mars.
@surface_n.times do
    land_x, land_y = gets.split(" ").collect {|x| x.to_i}
end

def getGroundHeight(x)
    100
end


loop do
    x, y, h_speed, v_speed, fuel, rotate, power = gets.split(" ").collect {|x| x.to_i}
    power = 0
    if v_speed != 0
        timeToImpact = ( v_speed + Math.sqrt( v_speed*v_speed + 2 * (y - getGroundHeight(x)) ) ) / 3.711
        timeToSlow = ((v_speed.abs - MaxLandingSpeed) / 0.289)  
     if (timeToImpact <= timeToSlow)
       power = 4
     end
    end


    # 2 integers: rotate power. rotate is the desired rotation angle (should be 0 for level 1), power is the desired thrust power (0 to 4).
    puts "0 #{power}"
end
