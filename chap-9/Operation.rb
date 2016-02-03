require "./Variable.rb"

class Add < Struct.new(:left, :right)
    def to_s
        "#{left} + #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

    def type(context)
		if left.type(context) == Type::NUMBER && right.type(context) == Type::NUMBER
			Type::NUMBER
		end
	end
end

class LessThan < Struct.new(:left, :right)
    def to_s
        "#{left} < #{right}"
    end

    def inspect
        "<<#{self}>>"
    end

	def type(context)
		if left.type(context) == Type::NUMBER && right.type(context) == Type::NUMBER
			Type::BOOLEAN
		end
	end
end