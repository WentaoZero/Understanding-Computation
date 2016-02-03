require "./Operation.rb"

class DoNothing
	def to_s
		'do-nothing'
	end

	def inspect
		"<<#{self}>>"
	end

	def type(context)
		Type::VOID
	end
end

class Assign < Struct.new(:name, :expression)
	def to_s
		"#{name} = #{expression}"
	end

	def inspect
		"<<#{self}>>"
	end

	def type(context)
		if context[name] = expression.type(context)
			Type::VOID
		end
	end
end

class Sequence < Struct.new(:first, :second)
    def to_s
        "#{first}; #{second}"
    end

    def inspect
        "<<#{self}"
    end

    def type(context)
    	if first.type(context) == Type::VOID && second.type(context) == Type::VOID
    		Type::VOID
    	end
    end
end

class ControlIf < Struct.new(:condition, :consequence, :alternative)
	def to_s
		"if (#{condition}) { #{consequence} } else { #{alternative} }"
	end

	def inspect
		"<<#{self}"
	end

	def type(context)
		if condition.type(context) == Type::BOOLEAN &&
			consequence.type(context) == Type::VOID &&
			alternative.type(context) == Type::VOID
			Type::VOID
		end
	end
end

class ControlWhile < Struct.new(:condition, :body)
	def to_s
		"while (#{condition}) { #{body} }"
	end

	def inspect
		"<<#{self}"
	end

	def type(context)
		if condition.type(context) == Type::BOOLEAN && body.type(context) == Type::VOID
			Type::VOID
		end
	end
end