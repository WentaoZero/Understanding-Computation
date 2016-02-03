require "treetop"
require "./NFA.rb"
require "./Pattern.rb"

rulebook = NFARulebook.new([
	FARule.new(1, "a", 1), FARule.new(1, "a", 2), FARule.new(1, nil, 2),
	FARule.new(2, "b", 3),
	FARule.new(3, "b", 1), FARule.new(3, nil, 2)
])

nfa_design = NFADesign.new(1, [3], rulebook)
simulation = NFASimulation.new(nfa_design)
dfa_design = simulation.to_dfa_design

puts dfa_design.accepts?("bbbabb")
puts dfa_design.accepts?("babb")
