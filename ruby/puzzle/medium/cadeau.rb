@n = gets.to_i
@cost = gets.to_i
budgets = []
total = 0
@paid = 0
@n.times do
  budget = gets.to_i
  budgets << budget
  total += budget
end
if (total < @cost)
    puts 'IMPOSSIBLE'
else 
    budgets.sort!
    budgets.each_with_index do |budget, i|
      participation = 0
      limit =  (@cost - @paid) / (@n-i)
      participation = budget <= limit ?  budget : limit
      @paid += participation
      puts "#{participation}"
    end
end

