#require "./FizzBuzz.rb"
#require "./Stream.rb"
require "./LambdaCalculus.rb"
require "treetop"

=begin
to_array(FizzBuzzSolution).each do |p|
	puts to_string(p)
end
=end

#print steam_to_array(ZEROS, 5).map { |p| to_integer(p) }
#print steam_to_array(UPWARDS_OF[ZERO], 5).map { |p| to_integer(p) }
#print steam_to_array(MULTIPLIES_OF[TWO], 5).map { |p| to_integer(p) }

#puts LambdaOne
#puts LambdaIncrement

=begin
expression = LCCall.new(LCCall.new(LambdaAdd, LambdaOne), LambdaOne)

puts expression

while expression.reducible?
	puts expression
	expression = expression.reduce
end

puts expression
=end

MyLambdaCalculusParser = Treetop.load("LambdaCalculus.treetop")
parse_tree = MyLambdaCalculusParser.new.parse("-> x { x[x] }[-> y { y }]")
expression = parse_tree.to_ast

puts expression
puts expression.reduce
