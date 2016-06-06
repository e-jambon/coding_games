@n = gets.to_i

currentMax = -1
maxLoss = 0

gets.split(" ").each do |value| 
    value = value.to_i
    currentMax = value if currentMax < value 
    loss = currentMax - value
    maxLoss = loss if loss > maxLoss
end

puts "#{-maxLoss}"
