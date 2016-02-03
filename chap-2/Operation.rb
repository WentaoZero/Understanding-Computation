require "./Variable.rb"

class Add < Struct.new(:left, :right)
    def to_s
        "#{left} + #{right}"
    end

	def to_ruby
		"-> e { (#{left.to_ruby}).call(e) + (#{right.to_ruby}).call(e) }"
	end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Add.new(left.reduce(environment), right)
        elsif right.reducible?
            Add.new(left, right.reduce(environment))
        else
            Number.new(left.value + right.value)
        end
    end
end

class Multiply < Struct.new(:left, :right)
    def to_s
        "#{left} * #{right}"
    end

	def to_ruby
		"-> e { (#{left.to_ruby}).call(e) * (#{right.to_ruby}).call(e) }"
	end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            Multiply.new(left.reduce(environment), right)
        elsif right.reducible?
            Multiply.new(left, right.reduce(environment))
        else
            Number.new(left.value * right.value)
        end
    end
end

class LessThan < Struct.new(:left, :right)
    def to_s
        "#{left} < #{right}"
    end

	def to_ruby
		"-> e { (#{left.to_ruby}).call(e) < (#{right.to_ruby}).call(e) }"
	end

    def inspect
        "<<#{self}>>"
    end

    def reducible?
        true
    end

    def reduce(environment)
        if left.reducible?
            LessThan.new(left.reduce(environment), right)
        elsif right.reducible?
            LessThan.new(left, right.reduce(environment))
        else
            Boolean.new(left.value < right.value)
        end
    end
end