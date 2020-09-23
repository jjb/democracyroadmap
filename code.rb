require 'ruby-graphviz'


# todo
# color for "goal which achieves better democracy"
# color for "goal which is result of better democracy" (or remove these)

g = GraphViz.new( :G, :type => :digraph )
g[:truecolor => true, :bgcolor => "transparent", :rankdir => "LR"]


# goals
goals = [
  expand_scotus = g.add_node( "Expand SCOTUS" ),
  scotus_term_limits = g.add_node( "SCOTUS term limits" ),
  expand_federal = g.add_node( "Expand Federal Courts" ),
  # legislation = g.add_node( "Pass Good Laws and \nDo Government Stuff" ),
  # representation = g.add_node( "More Accurate Federal Representation" ),
  campaign_finance = g.add_node( "Campaign Finance Reform" ),
  # elections = g.add_node( "Fair and Accessible Elections" ),
  gerrymandering_fed = g.add_node("Federal Gerrymandering Rules"),
  gerrymandering_state = g.add_node("Fix Gerrymandering In Some States"),
  ec_pact = g.add_node("Interstate Electoral College Pact"),
  remove_ec = g.add_node("Removal of Electoral College"),
  territories = g.add_node("Statehood for Territories"),
  dc = g.add_node("Statehood for DC"),
  senate = g.add_node( "Abolish/Reform Senate" ),
  filibuster = g.add_node( "Abolish Filibuster" ),
]
goals.each{|g| g[:color => 'gold']}

citizens_united = g.add_node( "Undo Citizen's United" )
# irv = g.add_node("Instant Runnoff Voting or Similar")
fed_trifecta = g.add_node( "Federal Trifecta" )

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
g.add_edge(const_convention, scotus_term_limits)
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
g.add_edge(senate_majority, expand_federal)
g.add_edge(win_presidency, expand_scotus)
g.add_edge(senate_majority, expand_scotus)
g.add_edge(win_presidency, expand_federal)

# g.add_edge(senate, representation)
# g.add_edge(dc, representation)
# g.add_edge(territories, representation)
# g.add_edge(gerrymandering_fed, representation)
# g.add_edge(gerrymandering_state, representation)
# g.add_edge(ec_pact, representation)
# g.add_edge(remove_ec, representation)
g.add_edge(expand_scotus, citizens_united)
g.add_edge(citizens_united, campaign_finance)
g.add_edge(fed_trifecta, campaign_finance)
# g.add_edge(citizens_united, elections)
g.add_edge(filibuster, dc)

# g.output( :png => "image.png" )
g.output(:svg => "graph.svg")
