require "./DTM.rb"

rulebook = DTMRulebook.new([
	TMRule.new(1, "X", 1, "X", :right),
	TMRule.new(1, "a", 2, "X", :right),
	TMRule.new(1, "_", 6, "_", :left),

	TMRule.new(2, "a", 2, "a", :right),
	TMRule.new(2, "X", 2, "X", :right),
	TMRule.new(2, "b", 3, "X", :right),

	TMRule.new(3, "b", 3, "b", :right),
	TMRule.new(3, "X", 3, "X", :right),
	TMRule.new(3, "c", 4, "X", :right),

	TMRule.new(4, "c", 4, "c", :right),
	TMRule.new(4, "_", 5, "_", :left),

	TMRule.new(5, "a", 5, "a", :left),
	TMRule.new(5, "b", 5, "b", :left),
	TMRule.new(5, "c", 5, "c", :left),
	TMRule.new(5, "X", 5, "X", :left),
	TMRule.new(5, "_", 1, "_", :right)
	])

tape = Tape.new([], "a", ["a", "a", "b", "b", "b", "c", "c", "c"], "_")
dtm = DTM.new(TMConfiguration.new(1, tape), [6], rulebook)
#10.times {dtm.step}; dtm.current_configuration
#25.times {dtm.step}; dtm.current_configuration
dtm.run
puts dtm.current_configuration
