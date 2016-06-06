STDOUT.sync = true # DO NOT REMOVE

@grid = []
@width = gets.to_i # the number of cells on the X axis
@height = gets.to_i # the number of cells on the Y axis

@height.times do
  line = gets.chomp # width characters, each either 0 or .
  @grid << line.split(//).map {|x| x=='.'? 0 : 1}
end

#throws coords of next right node or '-1 -1' if none found
def right(row, line)
  output = "-1 -1"
  found = false
  while row < @width -1 do
    output =  "#{row+1} #{line}" and break  if @grid[line][row+1]==1
    row += 1
  end
  output
end

#throws coords of next below node or '-1 -1' if none found
def below(row,line)
  output = '-1 -1'
  while line < @height -1 do
    output = "#{row} #{line+1}" and break if @grid[line+1][row]==1 
    line += 1
  end
  output
end

@grid.each_with_index do |line,line_index|
  line.each_with_index do |value, row_index|
    output = "#{row_index} #{line_index} "
    if value == 1
      output += right(row_index, line_index) + " "
      output += below(row_index, line_index)
      puts output
    end
  end
end 


