require "./Type.rb"

class Number < Struct.new(:value)
    def to_s
        value.to_s
    end

    def to_ruby
    	"-> e { #{value.inspect} }"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        false
    end

    def type(context)
		Type::NUMBER
	end
end

class Boolean < Struct.new(:value)
    def to_s
        value.to_s
    end

	def to_ruby
    	"-> e { #{value.inspect} }"
    end

    def inspect
        "#{self}"
    end

    def reducible?
        false
    end

	def type(context)
		Type::BOOLEAN
	end
end

class Variable < Struct.new(:name)
    def to_s
        name.to_s
    end

	def to_ruby
    	"-> e { e[#{name.inspect}] }"
    end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        environment[name]
    end

    def type(context)
    	context[name]
    end
end