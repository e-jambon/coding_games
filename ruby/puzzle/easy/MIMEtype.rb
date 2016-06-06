mimeTypes = Hash.new("UNKNOWN")
@n = gets.to_i # Number of elements which make up the association table.
@q = gets.to_i # Number Q of file names to be analyzed.
@n.times do
  ext, mt = gets.split(' ')
  mimeTypes[ext.downcase] = mt
end

@q.times do
  file = (gets.chomp + ' ').split('.') # One file name per line.
  extension = file.last.downcase.strip if file.length > 1
  puts "#{mimeTypes[extension]}"
end

