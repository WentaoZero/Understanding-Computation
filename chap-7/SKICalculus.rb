class SKISymbol < Struct.new(:name)
	def to_s
		name.to_s
	end

	def inspect
		to_s
	end

	def combinator
		self
	end

	def arguments
		[]
	end

	def callable?(*arguments)
		false
	end

	def reducible?
		false
	end

	def as_a_function_of(name)
		if self.name == name
			I
		else
			SKICall.new(K, self)
		end
	end

	def to_iota
		self
	end
end

class SKICall < Struct.new(:left, :right)
	def to_s
		"#{left}[#{right}]"
	end

	def inspect
		to_s
	end

	def combinator
		left.combinator
	end

	def arguments
		left.arguments + [right]
	end

	def reducible?
		left.reducible? || right.reducible? || combinator.callable?(*arguments)
	end

	def reduce
		if left.reducible?
			SKICall.new(left.reduce, right)
		elsif right.reducible?
			SKICall.new(left, right.reduce)
		else
			combinator.call(*arguments)
		end
	end

	def as_a_function_of(name)
		left_function  = left.as_a_function_of(name)
		right_function = right.as_a_function_of(name)

		SKICall.new(SKICall.new(S, left_function), right_function)
	end

	def to_iota
		SKICall.new(left.to_iota, right.to_iota)
	end
end

class SKICombinator < SKISymbol
	def callable?(*arguments)
		arguments.length == method(:call).arity
	end

	def as_a_function_of(name)
		SKICall.new(K, self)
	end
end

S, K, I = [:S, :K, :I].map { |name| SKICombinator.new(name) }
IOTA = SKICombinator.new("i")

def S.call(a, b, c)
	SKICall.new(SKICall.new(a, c), SKICall.new(b, c))
end

def S.to_iota
	SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, IOTA))))
end

def K.call(a, b)
	a
end

def K.to_iota
	SKICall.new(IOTA, SKICall.new(IOTA, SKICall.new(IOTA, IOTA)))
end

def I.call(a)
	a
end

def I.to_iota
	SKICall.new(IOTA, IOTA)
end

def IOTA.call(a)
	SKICall.new(SKICall.new(a, S), K)
end

def IOTA.callable?(*arguments)
	arguments.length == 1
end