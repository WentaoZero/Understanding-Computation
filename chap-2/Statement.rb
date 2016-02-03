class DoNothing
	def to_s
		'do-nothing'
	end

	def to_ruby
		"-> e { e }"
	end

	def inspect
		"<<#{self}>>"
	end

	def ==(other_statement)
		other_statement.instance_of?(DoNothing)
	end

	def reducible?
		false
	end
end

class Assign < Struct.new(:name, :expression)
	def to_s
		"#{name} = #{expression}"
	end

	def to_ruby
		"-> e { e.merge({ #{name.inspect} => (#{expression.to_ruby}).call(e) }) }"
	end

	def inspect
		"<<#{self}>>"
	end

	def reducible?
		true
	end

	def reduce(environment)
		if expression.reducible?
			[Assign.new(name, expression.reduce(environment)), environment]
		else
			[DoNothing.new, environment.merge({ name => expression})]
		end
	end
end

class Sequence < Struct.new(:first, :second)
    def to_s
        "#{first}; #{second}"
    end

    def to_ruby
    	"-> e { (#{second.to_ruby}).call((#{first.to_ruby}).call(e)) }"
    end

    def inspect
        "<<#{self}"
    end

    def reducible?
        true
    end

    def reduce(environment)
        case first
        when DoNothing.new
            [second, environment]
        else
            reduced_first, reduced_environment = first.reduce(environment)
            [Sequence.new(reduced_first, second), reduced_environment]
        end
    end
end