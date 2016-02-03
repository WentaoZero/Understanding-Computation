require "./PDA.rb"
require "./NPDA.rb"
require "./LexicalAnalyzer.rb"

start_rules = PDARule.new(1, nil, 2, "$", ["statement", "$"])
stop_rule = PDARule.new(2, nil, 3, "$", ["$"])

token_rules = LexicalAnalyzer::GRAMMAR.map do |rule|
	PDARule.new(2, rule[:token], 2, rule[:token], [])
end

symbol_rules = [
	# <statement> ::= <while> | <assign>
	PDARule.new(2, nil, 2, "statement", ["while"]),
	PDARule.new(2, nil, 2, "statement", ["assign"]),

	# <while> ::= "while" "(" <expression> ")" "{" <statement> "}"
	PDARule.new(2, nil, 2, "while", ["while", "(", "expression", ")", "{", "statement", "}"]),

	# <assign> ::= "value" "=" "expression"
	PDARule.new(2, nil, 2, "assign", ["value", "=", "expression"]),

	# <expression> ::= <less-than>
	PDARule.new(2, nil, 2, "expression", ["less-than"]),

	# <less-than> ::= <multiply> "<" <less-than> | <multiply>
	PDARule.new(2, nil, 2, "less-than", ["multiply", "<", "less-than"]),
	PDARule.new(2, nil, 2, "less-than", ["multiply"]),

	# <multiplay> ::= <term> "*" <multiply> | <term>
	PDARule.new(2, nil, 2, "multiply", ["term", "*", "multiply", "term"]),
	PDARule.new(2, nil, 2, "multiply", ["term"]),

	# <term> ::= "number" | "verb"
	PDARule.new(2, nil, 2, "term", ["number"]),
	PDARule.new(2, nil, 2, "term", ["verb"])
]

rulebook = NPDARulebook.new([start_rules, stop_rule] + symbol_rules + token_rules)
token_string = LexicalAnalyzer.new("while (x < 5) { x = x * 3}").analyze.join

puts token_string
