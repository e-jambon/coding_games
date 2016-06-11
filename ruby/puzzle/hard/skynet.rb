
STDOUT.sync = true # DO NOT REMOVE
require 'benchmark'
INITIALIZER = true
LINKED_GATEWAY = false
HAS_CRITICAL_PATH = false
SEVERE_LINK = true
LOWER_THREAT_LEVEL = false
ACTION = true
######################
#
#  INITIALIZATION
#
######################
# Soit defcon1 et defcon2 la liste des noeuds qui ont respectivement un, deux lien(s) avec un gateway.
@defcon2_nodes= []
@defcon1_nodes=[]


# Cartographie du réseau.
# ------------------------
# - Une carte sera représentée sous la forme d'un dictionnaire qui contient en clé l'ID du noeud, et en valeur la liste (tableau) des noeuds enfants

# On fera trois cartes du réseau :
# - une carte du réseau de tous les noeuds existants : full_map
# - Une carte des gateways : gateway_map
# - une carte du réseau defcon1 + defcon2.(union des deux) : defcon_map

# Carte de tout le réseau.
# TODO : renommer en full_map
@full_map = Hash.new

# Carte des gateways. - Sous ensemble réseau
@gateway_map = {}

# Carte des noeuds defcon - Sous ensemble réseau
@defcon_map=  {}

# Liste des gateway
@gateway_nodes= []

# Liste des liens supprimés (TODO : On devrait pas avoir à utiliser)
@deleted_links = []

# liste des liens (TODO : On ne devrait pas avoir besoin d'utiliser)
@links = []

#  Grabing game data
#  ----------------------
#  n: the total number of nodes in the level, including the gateways
#  l: the number of links
#  e: the number of exit gateways
@n, @l, @e = gets.split(' ').collect {|x| x.to_i}

@l.times do
  # n1 and n2 defines a link between these nodes
  n1, n2 = gets.split(' ').collect {|x| x.to_i}
  @full_map[n1]= [] unless @full_map.has_key?(n1)
  @full_map[n1] << n2  #Therefore we store the neighbors in the map
  @full_map[n2]= [] unless @full_map.has_key?(n2)
  @full_map[n2] << n1  #Therefore we store the neighbors in the map
  @links << [n1,n2]
end

@e.times do
  ei = gets.to_i # the index of a gateway node
  @gateway_nodes << ei
  @gateway_map[ei] = @full_map[ei]
end

# Function to initialize the defcon lists.
def initialize_defcon_lists
  @gateway_nodes.each do |gateway_node|
    @gateway_map[gateway_node].each do |node|
      @defcon1_nodes.include?(node) ? @defcon2_nodes << node : @defcon1_nodes << node
    end
  end
  # No duplicates in defcon2
  @defcon2_nodes.uniq!
  # remove defcon2 nodes from defcon1.
  @defcon1_nodes = @defcon1_nodes - @defcon2_nodes
end

# Function to add a list of nodes to add to the defcon_map
def add_to_defcon_map( defcon_list)
  defcon_list.each { |node| @defcon_map[node]= @full_map[node] }
end


# function to remove the non-gateway links from the links list.
# Keeping only the 'severable' links list
# This is needed because the links order must be preserved when providing output to the game AI.
def remove_nongateway_links
  # list of possibilities
  severable_links =[]
  defcon_nodes = @defcon1_nodes + @defcon2_nodes
  @gateway_map.each do |gateway,children|
    children.each do |child|
      if defcon_nodes.include?(child)
        severable_links << [gateway,child]
        severable_links << [child,gateway]
      end
    end
  end
  @links = severable_links & @links
end

# USING INIIALIZERS TO GET CLEAN DATA
#------------------------------------
if INITIALIZER
  STDERR.puts "BENCHMARK INITIALIZER :"
  STDERR.puts Benchmark.measure {
    initialize_defcon_lists
    add_to_defcon_map(@defcon1_nodes)
    add_to_defcon_map(@defcon2_nodes)
    remove_nongateway_links
  }
else
  initialize_defcon_lists
  add_to_defcon_map(@defcon1_nodes)
  add_to_defcon_map(@defcon2_nodes)
  remove_nongateway_links
end


if INITIALIZER
  STDERR.puts "gateways list : #{@gateway_nodes}"
  STDERR.puts "Defcon1 list  : #{@defcon1_nodes}"
  STDERR.puts "Defcon2 list  : #{@defcon2_nodes}"
  STDERR.puts "defcon_map    : #{@defcon_map}"
  STDERR.puts "Links list    : #{@links}"
end



######################
#
#  HELPERS
#
######################



# helper : returns an array containing the  defcon2 node in the given node list (array)
def filters_non_defcon2(node_list)
  node_list & @defcon2_nodes
end

# helper : returns an array containing the  defcon2 node in the given node list (array)
def filters_non_defcon1(node_list)
  node_list & @defcon1_nodes
end

# helper : returns an array containing only defcon nodes in a given list (array)
def filters_non_defcon_nodes(node_list)
  node_list & (@defcon1_nodes + @defcon2_nodes)
end

# helper that returns 1st found gateway node linked to a defcon node
def linked_gateway (defcon_node)

  subset = @links.select {|link| link[0] == defcon_node || link[1] == defcon_node }

  if LINKED_GATEWAY
    STDERR.puts "linked_gateway : @links = #{@links}"
    STDERR.puts "linked_gateway : defcon_node = #{defcon_node}"
    STDERR.puts "linked_gateway : subset = #{subset}"
    STDERR.puts "linked_gateway : result = #{subset[0][0] == defcon_node ? subset[0][1] : subset[0][0]}"
  end

  subset[0][0] == defcon_node ? subset[0][1] : subset[0][0]

end

# If the bot goes through defcon1 links, forcing us to severe a specific each move,
#  and ends up hitting a defcon2 node, then game_lost.

# Given a defcon1 node, finds if there is critical path.
# A critical path is a path that goes only through defcon1 nodes and targets a defcon2 node.
# if a critical path is found, returns the first found defcon2 candidate found.
# if no path was found, returns -1
def has_critical_path (defcon_node)
  # init
  visited =[]
  queue = @defcon_map[defcon_node]

  result = filters_non_defcon2(queue)
  if HAS_CRITICAL_PATH
    STDERR.puts "has_critical_path : defcon_node = #{defcon_node}"
    STDERR.puts "has_critical_path : queue =  #{queue}"
    STDERR.puts "has_critical_path : result =  #{result}"
  end
  # return if we have candidates
  if result.length > 0
    return result
  end


  # Therefore, there is no defcon2 map in queue,
  # would have returned otherwise.

  # provided we update data accordingly to current state
  while queue.length > 0
    current_node = queue.pop

    if !(visited.include?(current_node))
      visited += current_node
      child_nodes = @defcon_map[current_node]
      result = filters_non_defcon2(child_nodes)
      if result.length > 0
        return result
      end
      child_nodes.each do |child_node|
        (queue << child_node) unless visited.include?(child_node)
      end
    end
  end
  return []
end



# Given a defcon_node, lowers the threat level
# defcon2 -> defcon1 -> no threat.
# updates context data accordingly.
def lower_threat_level(defcon_node)
  # IF node1 or node2 is in defcon1, remove it from defcon1.
  if LOWER_THREAT_LEVEL
    STDERR.puts "lower_threat_level : IN "
    STDERR.puts "lower_threat_level : defcon_node = #{defcon_node}"
    STDERR.puts "lower_threat_level : @defcon2_nodes = #{@defcon2_nodes}"
    STDERR.puts "lower_threat_level : @defcon1_nodes = #{@defcon1_nodes}"
  end
  if @defcon1_nodes.include?(defcon_node)
    @defcon1_nodes.delete(defcon_node)
  end

  # IF node1 or node2 is in defcon2, then move the defcon node to defcon1.
  if @defcon2_nodes.include?(defcon_node)
    @defcon2_nodes.delete(defcon_node)
    @defcon1_nodes << defcon_node
  end
  if LOWER_THREAT_LEVEL
    STDERR.puts "lower_threat_level : RESULTS "
    STDERR.puts "lower_threat_level : defcon_node = #{defcon_node}"
    STDERR.puts "lower_threat_level : @defcon2_nodes = #{@defcon2_nodes}"
    STDERR.puts "lower_threat_level : @defcon1_nodes = #{@defcon1_nodes}"
  end
end

def on_severed_link(defcon_node,gateway_node)
  lower_threat_level(defcon_node)
  # ALWAYS remove the link from the maps
  @full_map[defcon_node].delete(gateway_node)
  @full_map[gateway_node].delete(defcon_node)
  @gateway_map[gateway_node].delete(defcon_node)
  @defcon_map[defcon_node].delete(gateway_node)
  # ALWAYS remove the link from the links lists.

end


def severe_link(defcon_node)

  gateway_node = linked_gateway (defcon_node)

  if SEVERE_LINK
    STDERR.puts "severe_link : defcon_node = #{defcon_node}"
    STDERR.puts "severe_link : gateway_node = #{gateway_node}"
  end

  on_severed_link(defcon_node, gateway_node)
  link = (@links.include?([gateway_node,defcon_node]) ? [gateway_node,defcon_node] : [defcon_node,gateway_node])
  @links.delete(link)

  if SEVERE_LINK
    STDERR.puts "severe_link : link = #{link}' "
    STDERR.puts "severe_link : puts \"#{link[0]} #{link[1]}\""
  end

  puts "#{link[0]} #{link[1]}"
end


######################
#
#  THIRD STEP : STRATEGY
#
######################

def action(skybot_node)

  # Fist things. If skynet is on a defcon1 node, we have no choice.
  if @defcon1_nodes.include?(skybot_node)
    severe_link(skybot_node)
    return
  end

  if ACTION
    STDERR.puts "action : defcon1 : #{@defcon1_nodes}"
    STDERR.puts "action : skybot is not in defcon1"
  end

  # Second thing : One level away matters :
  children_lvl_one = @full_map[skybot_node]
  if ACTION
    STDERR.puts "action : lvl 1 children #{children_lvl_one}"
  end

  l1_defcon2_nodes = filters_non_defcon2(children_lvl_one)
  l1_defcon1_nodes = filters_non_defcon1(children_lvl_one)
  if ACTION
    STDERR.puts "action : lvl 1 defcon2 nodes  #{l1_defcon2_nodes} "
    STDERR.puts "action : lvl 1 defcon1 nodes #{l1_defcon1_nodes} "
  end

  # Is there a defcon2 node ahead ?
  if l1_defcon2_nodes.length > 0
    if ACTION
      STDERR.puts "action : found defcon2 lvl1 :::: #{l1_defcon2_nodes} "
    end
    severe_link(l1_defcon2_nodes[0])
    return
  end


  # Is there a critical path ahead ?
  if l1_defcon1_nodes.length > 1
    if ACTION
      STDERR.puts "action : Looking for critical path from 1 lvl away"
    end
    l1_defcon1_nodes.each do |node|
      l1_crit_node = has_critical_path(node)
      severe_link(l1_crit_node[0]) if l1_crit_node.length >= 0
      return
    end
    #no critical path ahead -> delete first link.
    severe_link(l1_defcon1_nodes[0])
    return
  end

  # Third thing : Two nodes away matters :





  #children_lvl_two
  # Is there a critical path ahead ?
  if ACTION
    STDERR.puts "action : removing a defcon link"
  end

  if !(@defcon2_nodes.empty?)
    severe_link(@defcon2_nodes[0])
  else !(@defcon1_nodes.empty?)
  severe_link(@defcon1_nodes[0])
  return
  end

end



loop do
  si = gets.to_i
  STDERR.puts "Skybot position : #{si}"
  action(si)
end

