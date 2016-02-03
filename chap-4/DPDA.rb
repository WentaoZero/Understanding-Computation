require "./Stack.rb"
require "./PDA.rb"

class DPDARulebook < Struct.new(:rules)
	def next_configuration(configuration, character)
		rule_for(configuration, character).follow(configuration)
	end

	def applies_to?(configuration, character)
		!rule_for(configuration, character).nil?
	end

	def rule_for(configuration, character)
		rules.detect { |rule| rule.applies_to?(configuration, character) }
	end

	def follow_free_moves(configuration)
		if applies_to?(configuration, nil)
			follow_free_moves(next_configuration(configuration, nil))
		else
			configuration
		end
	end
end

class DPDA < Struct.new(:current_configuration, :accept_states, :rulebook)
	def accepting?
		accept_states.include?(current_configuration.state)
	end

	def read_character(character)
		self.current_configuration = rulebook.next_configuration(current_configuration, character)
	end

	def read_string(string)
		string.chars.each do |character|
			read_character(character)
		end
	end

	def current_configuration
		rulebook.follow_free_moves(super)
	end
end

class DPDADesign < Struct.new(:start_state, :bottom_character, :accept_states, :rulebook)
	def accepts?(string)
		to_dpda.tap { |dpda| dpda.read_string(string) }.accepting?
	end

	def to_dpda
		start_stack = Stack.new([bottom_character])
		start_configuration = PDAConfiguration.new(start_state, start_stack)
		DPDA.new(start_configuration, accept_states, rulebook)
	end
end

class DPDA
	def next_configuration(character)
		if rulebook.applies_to?(current_configuration, character)
			rulebook.next_configuration(current_configuration, character)
		else
			current_configuration.stuck
		end
	end

	def stuck?
		current_configuration.stuck?
	end

	def read_character(character)
		self.current_configuration = (next_configuration(character))
	end

	def read_string(string)
		string.chars.each do |character|
			read_character(character) unless stuck?
		end
	end
end