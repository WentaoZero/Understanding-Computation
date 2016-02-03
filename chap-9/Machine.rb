require "./Statement.rb"

=begin
inputs  = Sign::NEGATIVE, Sign::ZERO, Sign::POSITIVE
outputs = inputs.product(inputs).map { |x, y| sum_of_squares(x, y)}
puts outputs.uniq
=end


expression = Add.new(Variable.new(:x), Variable.new(:y))

#puts expression.type({ x: Type::NUMBER, y: Type::NUMBER})

puts ControlIf.new(
	LessThan.new(Number.new(1), Number.new(2)), DoNothing.new, DoNothing.new
).type({})

statement =
	ControlWhile.new(
		LessThan.new(Variable.new(:x), Number.new(5)),
		Assign.new(:x, Add.new(Variable.new(:x), Number.new(3)))
)

puts statement

puts statement.type({ x: Type::NUMBER})