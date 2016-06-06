STDOUT.sync = true # DO NOT REMOVE
# n: the total number of nodes in the level, including the gateways
# l: the number of links
# e: the number of exit gateways

@virusGateways=[]
@virusLinks=[]
@n, @l, @e = gets.split(" ").collect {|x| x.to_i}
@l.times do
  # n1: N1 and N2 defines a link between these nodes
  n1, n2 = gets.split(' ').collect { |x| x.to_i }
  @virusLinks << [n1, n2]
end

@e.times do
  ei = gets.to_i # the index of a gateway node
  @virusGateways << ei
end

def severeLink(link)
  puts "#{link[0]} #{link[1]}"
  @virusLinks.delete(link)
end

def action(si)
  matchedLinks= [];
  for i in 0..@e-1
    gateway = @virusGateways[i]
    l = @virusLinks.find { |link| link == [gateway,si] || link == [si,gateway] }
    l && (matchedLinks = l)
    i +=1
  end
  matchedLinks.empty?  ?  (links = @virusLinks[0]) : (links= matchedLinks)
  severeLink(links)
end

# game loop
loop do
  si = gets.to_i # The index of the node on which the Skynet agent is positioned this turn    
  action(si)
end

