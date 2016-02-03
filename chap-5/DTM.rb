require "./TuringMachine.rb"

class DTMRulebook < Struct.new(:rules)
	def next_configuration(configuration)
		rule_for(configuration).follow(configuration)
	end

	def rule_for(configuration)
		rules.detect { |rule| rule.applies_to?(configuration)}
	end

	def applies_to?(configuration)
		!rule_for(configuration).nil?
	end
end

class DTM < Struct.new(:current_configuration, :accept_states, :rulebook)
	def accepting?
		accept_states.include?(current_configuration.state)
	end

	def step
		self.current_configuration = rulebook.next_configuration(current_configuration)
	end

	def stuck?
		!accepting? && !rulebook.applies_to?(current_configuration)
	end

	def run
		step until accepting? || stuck?
	end
end