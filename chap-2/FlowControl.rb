require "./Variable.rb"

class ControlIf < Struct.new(:condition, :consequence, :alternative)
	def to_s
		"if (#{condition}) { #{consequence} } else { #{alternative} }"
	end

	def to_ruby
		"-> e { if (#{condition.to_ruby}).call(e)" +
		  " then (#{consequence.to_ruby}).call(e)" +
		  " else (#{alternative.to_ruby}).call(e)" +
		  " end }"
	end

	def inspect
		"<<#{self}"
	end

	def reducible?
		true
	end

	def reduce(environment)
		if condition.reducible?
			[ControlIf.new(condition.reduce(environment), consequence, alternative), environment]
		else
			case condition
			when Boolean.new(true)
				[consequence, environment]
			when Boolean.new(false)
				[alternative, environment]
			end
		end
	end
end

class ControlWhile < Struct.new(:condition, :body)
	def to_s
		"while (#{condition}) { #{body} }"
	end

	def to_ruby
		"-> e {" +
		" while (#{condition.to_ruby}).call(e);" +
		" e = (#{body.to_ruby}).call(e);" +
		" end;" +
		" e" +
		" }"
	end

	def inspect
		"<<#{self}"
	end

	def reducible?
		true
	end

	def reduce(environment)
		[ControlIf.new(condition, Sequence.new(body, self), DoNothing.new), environment]
	end
end