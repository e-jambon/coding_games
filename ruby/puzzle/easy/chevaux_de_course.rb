#quick & dirty

@defibrillators = Array.new
@distances = Array.new
@lon = gets.chomp.gsub(",",".").to_f
@lat = gets.chomp.gsub(",",".").to_f
@n = gets.to_i

@n.times do |index|
  @defibrillators << gets.chomp.split(';')
end


@defibrillators.each_with_index do | defibrillator, index|
  defibrillator[4].gsub!(',','.')
  defibrillator[5].gsub!(',','.')
  x = (@lon - @defibrillators[index][4].to_f) * Math.cos((@lat+@defibrillators[index-1][5].to_f) /2)
  y = (@lat - @defibrillators[index][5].to_f)
  @distances << Math.sqrt(x*x + y*y)*6371
end

puts "#{@defibrillators[@distances.index(@distances.min)][1]}"
