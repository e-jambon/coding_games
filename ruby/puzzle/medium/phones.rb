
ne_map = {}

@n = gets.to_i
@n.times do
    telephone = gets.chomp
        telephone.length.times do |count| 
                sub = telephone[ 0..count]
                        @phone_map[sub]= count  unless @phone_map.has_key?(sub)
    end
    end


# The number of elements (referencing a number) stored in the structure.
# puts "#{@phone_map.length}"
