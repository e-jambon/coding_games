n = gets.to_i # the number of adjacency relations

@result = -1

# map will be a representation of the nodes. key = node name ; value = An array containing related nodes.

@map = Hash.new()

n.times do
  # xi: the ID of a person which is adjacent to yi
  # yi: the ID of a person which is adjacent to xi
  xi, yi = gets.split(" ").collect {|x| x.to_i}
  # construct of map
  @map[xi]= [] unless @map.has_key?(xi)
  @map[xi] << yi  #Therefore we store the neighbors
  @map[yi]= [] unless @map.has_key?(yi)
  @map[yi] << xi  #Therefore we store the neighbors
end


#nodes_start is an containing the node we want to start with.
def traverse_matrix (node_start)
  visited_node  = []
  level_nodes = [node_start]
  number_of_levels = 0
  while !(level_nodes.empty?)
    number_of_levels += 1
    # add each node in level_nodes to the visited_node list.
    visited_node += level_nodes  # now the whole level is marked as visited
    # Lets find all childs of those nodes
    next_level_nodes =[]
    level_nodes.each do |node|
      @map[node].each { |children| next_level_nodes << children  }
    end
    # Remove from level_nodes all those nodes that are already visited
    # since they are part of a previous level
    level_nodes = (next_level_nodes - visited_node).uniq 
  end

  # we want to know how many levels were found in the end, when the queue is empty (we have visited the whole tree)
  # Hence it's the result.
  number_of_levels
end

# Method to find only leaves in the tree.
# Since all nodes are connected, those that are linked to only one other node are leaves.
# Returns first found leaf.
# TODO : Whatif the tree is empty and there are no links ?
def get_leaf (tree_map)
  leaf = []
  i=0
  tree_map.each do |node,childs|
    if childs.length == 1 && !(leaf.include?(node))
        leaf << node 
        break unless leaf.empty?
    end
  end
  #STDERR.puts "leaf #{leaf}"
  leaf[0]
end

# The longest possible path in the tree will necessarily start with a leaf and end with a leaf.
# Therefore we only compute the lengh of for every leaf.

leaf = get_leaf(@map)
max_length = traverse_matrix(leaf)

best_propagation_time = max_length/2

puts "#{best_propagation_time}"

