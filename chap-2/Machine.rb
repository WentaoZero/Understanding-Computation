require "treetop"
require "./FlowControl.rb"
require "./Operation.rb"
require "./Statement.rb"

class Machine < Struct.new(:statement, :environment)
	def step
		self.statement, self.environment = statement.reduce(environment)
	end

	def run
		while statement.reducible?
			puts "#{statement}, #{environment}"
			step
		end

		puts "#{statement}, #{environment}"
	end
end

my_parser  = Treetop.load("Simple.treetop")
parse_tree = my_parser.new.parse("while (x < 5) { x = x * 3 }")
statement = parse_tree.to_ast

puts statement
#statement.eval
