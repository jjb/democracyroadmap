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
senate = g.add_nodes( "Abolish the Senate" )

# dependencies
const_convention = g.add_nodes( "Constitutional Convention" )
majority_state_trifectas = g.add_nodes( "Majority of States With Trifectas" )

# relationships
g.add_edge(const_convention, senate)
g.add_edge(const_convention, remove_ec)
g.add_edge(majority_state_trifectas, ec_pact)

# Generate output image
g.output( :png => "image.png" )
