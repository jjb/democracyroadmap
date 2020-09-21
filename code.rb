require 'ruby-graphviz'

# Create a new graph
g = GraphViz.new( :G, :type => :digraph )

# goals
gerrymandering = g.add_node("fix gerrymandering")
ec_pact = g.add_node("interstate electoral college pact")
remove_ec = g.add_node("full-blown removal of electoral college")
dc = g.add_node("statehood for DC")
territories = g.add_node("statehood for territories")
irv = g.add_node("Instant runnoff voting or other system with similar goals")
senate = g.add_node( "Abolish the Senate" )
filibuster = g.add_node( "Abolish the Filibuster" )
fed_trifecta = g.add_node( "Federal Trifecta" )
expand_scotus = g.add_node( "Expand SCOTUS" )
eppand_federal = g.add_node( "Expand Federal Courts" )

# dependencies
const_convention = g.add_node( "Constitutional Convention" )
majority_state_trifectas = g.add_node( "Majority of States With Trifectas" )
win_presidency = g.add_node( "Presidency" )
senate_majority = g.add_node( "Senate Majority" )
house_majority = g.add_node( "House Majority" )

# relationships
g.add_edge(const_convention, senate)
g.add_edge(const_convention, remove_ec)
g.add_edge(majority_state_trifectas, ec_pact)
g.add_edge(win_presidency, fed_trifecta)
g.add_edge(senate_majority, fed_trifecta)
g.add_edge(house_majority, fed_trifecta)
g.add_edge(senate_majority, filibuster)

# Generate output image
g.output( :png => "image.png" )
