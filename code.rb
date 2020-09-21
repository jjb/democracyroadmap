require 'ruby-graphviz'

# Create a new graph
g = GraphViz.new( :G, :type => :digraph )
# g.node["shape"] = "circle"
g[:truecolor => true, :bgcolor => "transparent", :rankdir => "LR"]


# goals
gerrymandering_fed = g.add_node("Federal Gerrymandering Rules")
gerrymandering_state = g.add_node("Fix Gerrymandering In Some States")
ec_pact = g.add_node("Interstate Electoral College Pact")
remove_ec = g.add_node("Removal of Electoral College")
dc = g.add_node("Statehood for DC")
territories = g.add_node("Statehood for Territories")
# irv = g.add_node("Instant Runnoff Voting or Similar")
senate = g.add_node( "Abolish Senate" )
filibuster = g.add_node( "Abolish Filibuster" )
fed_trifecta = g.add_node( "Federal Trifecta" )
expand_scotus = g.add_node( "Expand SCOTUS" )
eppand_federal = g.add_node( "Expand Federal Courts" )

# dependencies
const_convention = g.add_node( "Constitutional Convention" )
more_state_trifectas = g.add_node( "More State Trifectas" )
majority_state_trifectas = g.add_node( "Majority of States With Trifectas" )
two_thirds_state_trifectas = g.add_node( "2/3 of States With Trifectas" )
win_presidency = g.add_node( "Presidency" )
senate_majority = g.add_node( "Senate Majority" )
house_majority = g.add_node( "House Majority" )
gotv = g.add_node( "Get Out The Vote!" )

# relationships
g.add_edge(const_convention, senate)
g.add_edge(const_convention, remove_ec)
g.add_edge(majority_state_trifectas, ec_pact)
g.add_edge(win_presidency, fed_trifecta)
g.add_edge(senate_majority, fed_trifecta)
g.add_edge(house_majority, fed_trifecta)
g.add_edge(senate_majority, filibuster)
g.add_edge(more_state_trifectas, gerrymandering_state)
g.add_edge(more_state_trifectas, majority_state_trifectas)
g.add_edge(majority_state_trifectas, two_thirds_state_trifectas)
g.add_edge(two_thirds_state_trifectas, const_convention)
g.add_edge(gotv, more_state_trifectas)
g.add_edge(fed_trifecta, gerrymandering_fed)
g.add_edge(gotv, win_presidency)
g.add_edge(gotv, senate_majority)
g.add_edge(gotv, house_majority)
g.add_edge(fed_trifecta, dc)
g.add_edge(fed_trifecta, territories)
g.add_edge(fed_trifecta, eppand_federal)
g.add_edge(fed_trifecta, expand_scotus)

# Generate output image
g.output( :png => "image.png" )
