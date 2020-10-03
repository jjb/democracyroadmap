require 'ruby-graphviz'
require 'erb'

# todo
# color for "goal which achieves better democracy"
# color for "goal which is result of better democracy" (or remove these)

g = GraphViz.new( :G, :type => 'digraph' )
g.node[shape: 'circle', style: 'filled', fontname: 'garamond', fillcolor: 'white',
  fontsize:'20px', penwidth: '3px', fixedsize: true, width: 2.3, height: 2.3]

g[:truecolor => true, :bgcolor => "transparent"]

# goals
goals = [
  expand_scotus = g.add_node( "Expand\nSCOTUS" ),
  scotus_term_limits = g.add_node( "SCOTUS\nterm limits" ),
  expand_federal = g.add_node( "Expand\nFederal Courts" ),
  campaign_finance = g.add_node( "Campaign Finance\nReform" ),
  # elections = g.add_node( "Fair and Accessible Elections" ),
  gerrymandering_fed = g.add_node("Federal\nGerrymandering\nRules", URL: 'https://democraticredistricting.com/', target: 'new'),
  gerrymandering_state = g.add_node("Fix Gerrymandering\nIn Some States", URL: 'https://democraticredistricting.com/', target: 'new'),
  ec_pact = g.add_node("Interstate Electoral\nCollege Pact", URL: "https://www.nationalpopularvote.com/written-explanation", target: 'new'),
  remove_ec = g.add_node("Removal of\nElectoral College"),
  territories = g.add_node("Statehood for\nTerritories"),
  dc = g.add_node("Statehood for\nDC"),
  senate = g.add_node( "Reform\nSenate" ),
  filibuster = g.add_node( "Abolish\nFilibuster" ),
  expand_house = g.add_node( "Expand\nHouse", target: "new", URL: 'https://www.reddit.com/r/UncapTheHouse/comments/ekv0w7/welcome_to_runcapthehouse_click_here_for_more/')
]
goals.each{|g| g[:color => 'gold']}

legislation = g.add_node( "Ability to\nPass Legislation", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )

citizens_united = g.add_node( "Undo\nCitizen's United", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )
# irv = g.add_node("Instant Runnoff Voting or Similar")
fed_trifecta = g.add_node( "Federal Trifecta", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )

# dependencies
const_convention = g.add_node( "Constitutional\nConvention", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )
more_state_trifectas = g.add_node( "More\nState Trifectas", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )
majority_state_trifectas = g.add_node( "Majority\nState Trifectas", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )
two_thirds_state_trifectas = g.add_node( "2/3\nState Trifectas", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px' )
house_majority = g.add_node( "House Majority", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px')
senate_majority = g.add_node( "Senate Majority", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px')
win_presidency = g.add_node( "Presidency", shape: 'square', fontsize:'16px', width: 1.5, height: 1.5, penwidth: '2px')
gotv = g.add_node( "Click Here to\nGet Out\nThe Vote!", shape: "circle", style: 'filled', fontname: 'garamond',
  fillcolor: 'white', fontcolor:'red', color:'blue', fontsize:'36px', penwidth: '4px', URL: "/gotv",
  width: 3, height: 3 )

# relationships
g.add_edge(citizens_united, campaign_finance)
g.add_edge(const_convention, remove_ec)
g.add_edge(const_convention, scotus_term_limits)
g.add_edge(const_convention, senate)
g.add_edge(expand_scotus, citizens_united)
g.add_edge(fed_trifecta, legislation)
g.add_edge(filibuster, legislation)
g.add_edge(gotv, house_majority)
g.add_edge(gotv, more_state_trifectas)
g.add_edge(gotv, senate_majority)
g.add_edge(gotv, win_presidency)
g.add_edge(house_majority, fed_trifecta)
g.add_edge(legislation, campaign_finance)
g.add_edge(legislation, dc)
g.add_edge(legislation, expand_house)
g.add_edge(legislation, gerrymandering_fed)
g.add_edge(legislation, territories)
g.add_edge(majority_state_trifectas, ec_pact)
g.add_edge(majority_state_trifectas, two_thirds_state_trifectas)
g.add_edge(more_state_trifectas, gerrymandering_state)
g.add_edge(more_state_trifectas, majority_state_trifectas)
g.add_edge(senate_majority, expand_federal)
g.add_edge(senate_majority, expand_scotus)
g.add_edge(senate_majority, fed_trifecta)
g.add_edge(senate_majority, filibuster)
g.add_edge(two_thirds_state_trifectas, const_convention)
g.add_edge(win_presidency, expand_federal)
g.add_edge(win_presidency, expand_scotus)
g.add_edge(win_presidency, fed_trifecta)

g.output(:png => "graph.png")
g.output(:svg => "graph.svg")

`erb index.html.erb > index.html`
