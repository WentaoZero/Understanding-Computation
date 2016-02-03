class Type < Struct.new(:name)
	NUMBER, BOOLEAN = [:number, :boolean].map { |name| new(name) }
	VOID = new(:void)

	def inspect
		"#<Type #{name}>"
	end
end