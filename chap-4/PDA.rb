class PDAConfiguration < Struct.new(:state, :stack)
	STUCK_STATE = Object.new

	def stuck
		PDAConfiguration.new(STUCK_STATE, stack)
	end

	def stuck?
		state == STUCK_STATE
	end
end

class PDARule < Struct.new(:state, :character, :next_state, :pop_character, :push_characters)
	def applies_to?(configuration, character)
		self.state         == configuration.state     &&
		self.pop_character == configuration.stack.top &&
		self.character     == character
	end
end

class PDARule
	def follow(configuration)
		PDAConfiguration.new(next_state, next_stack(configuration))
	end

	def next_stack(configuration)
		popped_stack = configuration.stack.pop

		push_characters.reverse.inject(popped_stack) { |stack, character| stack.push(character) }
	end
end