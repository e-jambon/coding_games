@n = gets.to_i
@words = []
@n.times do
  @words << gets.chomp
end

@deck_letters = gets.chomp

# checks if a word can be written with @dekLetters
def can_be_written?(word)
    word.chars.uniq.all?{ |c| @deck_letters.count(c) >= word.count(c) } 
end


# Computes a word value according to rules
def word_value(word)
  value = 0
  # from the rules
  letter_values = {'e' => 1, 'a' => 1 , 'i'=> 1, 'o' => 1,
                  'n' => 1, 'r' => 1, 't' => 1, 'l' => 1,
                  's' => 1, 'u' => 1,
                  'd' => 2 , 'g' => 2,
                  'b' => 3, 'c' => 3, 'm' => 3, 'p' => 3,
                  'f' => 4, 'h' => 4, 'v' => 4, 'w' => 4, 'y' => 4,
                  'k' => 5,
                  'j'=> 8 , 'x' => 8,
                  'q' => 10 , 'z' => 10 }
  word.split('').each do |letter|
    value += letter_values[letter]
  end
  value
end

candidates = []

# extract candidates
@words.each do |word|
  copy = word
  value = word_value(word)
  candidates << [copy,value] if can_be_written?(word)
end

candidates.sort_by! {|candidate| [-candidate[1],candidates.index(candidate)]}
puts candidates.first[0]
