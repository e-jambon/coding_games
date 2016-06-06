gets.to_i <= 0 ? (puts 0) : (puts gets.chomp.split(" ").map(&:to_i).map {|x| [x.abs,x]}.sort.to_h.min[1])
