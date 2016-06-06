
STDOUT.sync = true # DO NOT REMOVE
require 'benchmark'
DEBUG = true


##### TRAVAIL EN COURS.
##### NOTE : Non fonctionnel. Implémentation interrompue.
##### TODO : trouve le chemin critique qui mène à un noeud defcon2.



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
@n, @l, @e = gets.split(" ").collect {|x| x.to_i}

@l.times do
  # n1 and n2 defines a link between these nodes
  n1, n2 = gets.split(" ").collect {|x| x.to_i}
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


# function to remove the non-gateway links, therefore keeping only the severable links list
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
if DEBUG
  STDERR.puts "BENCHMARK INITIALIZER :"
  STDERR.puts Benchmark.measure {
    initialize_defcon_lists
      add_to_defcon_map(@defcon1_nodes)
      add_to_defcon_map(@defcon2_nodes)
      remove_nongateway_links
  }
end


if DEBUG
  STDERR.puts "gateways list : #{@gateway_nodes}"
  STDERR.puts "Defcon1 list  : #{@defcon1_nodes}"
  STDERR.puts "Defcon2 list  : #{@defcon2_nodes}"
  STDERR.puts "defcon_map    : #{@defcon_map}"
  STDERR.puts "Links list    : #{@links}"
end
