STDOUT.sync = true # DO NOT REMOVE
# Auto-generated code below aims at helping you parse
# the standard input according to the problem statement.

# nb_floors: number of floors
# width: width of the area
# nb_rounds: maximum number of rounds
# exit_floor: floor on which the exit is found
# exit_pos: position of the exit on its floor
# nb_total_clones: number of generated clones
# nb_additional_elevators: ignore (always zero)
# nb_elevators: number of elevators
@nb_floors, @width, @nb_rounds, @exit_floor, @exit_pos, @nb_total_clones, @nb_additional_elevators, @nb_elevators = gets.split(" ").collect {|x| x.to_i}
@elevators = Hash.new
@lastBlocked = Hash.new
@action = 'WAIT'
@nb_elevators.times do
    # elevator_floor: floor on which this elevator is found
    # elevator_pos: position of the elevator on its floor
    elevator_floor, elevator_pos = gets.split(" ").collect {|x| x.to_i}
    @elevators[elevator_floor] =  elevator_pos
end

def wait 
    @action= "WAIT" 
end
def block
    @lastBlocked = [@clone_floor, @clone_pos]
    @action= "BLOCK"
end

def isNotAboveElevator?
    @elevators[@clone_floor-1] == @clone_pos 
end

def hasWrongDirection? (objectif_pos)
    dir = objectif_pos - @clone_pos 
    !( (dir<0  && @direction == 'LEFT') || (dir > 0 && @direction == 'RIGHT'))
end


loop do
    
    # clone_floor: floor of the leading clone
    # clone_pos: position of the leading clone on its floor
    # direction: direction of the leading clone: LEFT or RIGHT
    
    clone_floor, clone_pos, @direction = gets.split(" ")
    @clone_floor = clone_floor.to_i
    @clone_pos = clone_pos.to_i
    
    wait
    if @lastBlocked.empty? && @clone_floor == 0 
        block if (@direction == 'RIGHT' && @clone_pos == (@width-1)) || (@clone_pos == 1 && @direction == 'LEFT' )
    
    elsif (@clone_floor >= 1 && @lastBlocked.empty?) || @clone_floor > @lastBlocked[0] 
        if (@clone_floor == @exit_floor) # on exit floor
            STDERR.puts "on exit floor"
            block if  ( isNotAboveElevator?  && hasWrongDirection?(@exit_pos) )
        elsif isNotAboveElevator?  # all floors, unless above elevator
            block if  hasWrongDirection?(@elevators[@clone_floor]) 
        end
    end
    puts @action
end
