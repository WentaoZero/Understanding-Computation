#require "./Tape.rb"
#require "./PartialRecursion.rb"
#require "./SKICalculus.rb"
#require "./LambdaCalculus.rb"
#require "treetop"
require "./TagSystem.rb"
#require "./CyclicTagSystem.rb"

=begin
current_tape = TAPE[EMPTY][ZERO][EMPTY][ZERO]
current_tape = TAPE_WRITE[current_tape][ONE]
current_tape = TAPE_MOVE_HEAD_RIGHT[current_tape]
current_tape = TAPE_WRITE[current_tape][TWO]
current_tape = TAPE_MOVE_HEAD_RIGHT[current_tape]
current_tape = TAPE_WRITE[current_tape][THREE]
current_tape = TAPE_MOVE_HEAD_RIGHT[current_tape]

print to_array(TAPE_LEFT[current_tape]).map { |p| to_integer(p)}
=end

=begin
six = multiply(two, three)
puts divide(six, two)
ten = increment(multiply(three, three))
puts divide(ten, three)
=end

=begin
MyLambdaCalculusParser = Treetop.load("LambdaCalculus.treetop")
two = MyLambdaCalculusParser.new.parse("-> p { -> x { p[p[x]] } }").to_ast
inc, zero = SKISymbol.new(:inc), SKISymbol.new(:zero)
expression = SKICall.new(SKICall.new(two.to_ski, inc), zero)


while expression.reducible?
	puts expression
	expression = expression.reduce
end
puts expression
=end

=begin
MyLambdaCalculusParser = Treetop.load("LambdaCalculus.treetop")
two = MyLambdaCalculusParser.new.parse("-> p { -> x { p[p[x]] } }").to_ast
inc, zero = SKISymbol.new(:inc), SKISymbol.new(:zero)
expression = SKICall.new(SKICall.new(two.to_ski, inc), zero)

puts two
print "\n"
puts two.to_ski
print "\n"
puts two.to_ski.to_iota

expression = SKICall.new(SKICall.new(two.to_ski.to_iota, inc), zero)
puts expression
print "\n"

expression = expression.reduce while expression.reducible?

puts expression
=end

=begin
rulebook = TagRulebook.new(2, [
	TagRule.new("a", "cc"), TagRule.new("b", "d"),
	TagRule.new("c", "eo"), TagRule.new("d", ""),
	TagRule.new("e", "e")])

system = TagSystem.new("aabbbbbbbb", rulebook)
system.run

print "\n"

system = TagSystem.new("aabbbbbb", rulebook)
system.run
=end


rulebook = TagRulebook.new(2, [TagRule.new("a", "ccdd"), TagRule.new("b", "dd")])
system = TagSystem.new("aabbbb", rulebook)

cyclic_system = system.to_cyclic

cyclic_system.run

=begin
encoder = system.encoder
puts encoder.encode_character("c")
puts encoder.encode_string("cab")
rule = system.rulebook.rules.first

puts rule.to_cyclic(encoder)

=end
