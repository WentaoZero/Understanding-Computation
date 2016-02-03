require "./Container.rb"

TEN = MULTIPLY[TWO][FIVE]
B   = TEN
F   = INCREMENT[B]
I   = INCREMENT[F]
U   = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

def to_char(c)
	"0123456789BFiuz".slice(to_integer(c))
end

def to_string(s)
	to_array(s).map { |c| to_char(c) }.join
end

def to_digits(n)
	previous_digits =
		if n < 10
			[]
		else
			to_digits(n / 10)
		end
	previous_digits.push(n % 10)
end

MOD =
	Z_COMBINATOR[-> f { -> m { -> n {
		CONTROL_IF[IS_LESS_OR_EQUAL[n][m]][
			-> x {
				f[SUBTRACT[m][n]][n][x]
			}
		][
			m
		]
	} } }]

=begin
MOD =
	-> m { -> n {
		m[-> x {
			CONTROL_IF[IS_LESS_OR_EQUAL[n][x]][
				SUBTRACT[x][n]
			][
				x
			]
		}][m]
	} }
=end

DIV =
	Z_COMBINATOR[-> f { -> m { -> n {
		CONTROL_IF[IS_LESS_OR_EQUAL[n][m]][
			-> x {
				INCREMENT[f[SUBTRACT[m][n]][n]][x]
				}
			][
				ZERO
			]
		} } }]

TO_DIGITS =
	Z_COMBINATOR[-> f { -> n { PUSH[
		CONTROL_IF[IS_LESS_OR_EQUAL[n][DECREMENT[TEN]]][
			EMPTY
		][
			-> x {
				f[DIV[n][TEN]][x]
				}
			]
		][MOD[n][TEN]] } }]

FIFTEEN = ADD[TEN][FIVE]
THIRTY 	= MULTIPLY[FIFTEEN][TWO]

FizzBuzzSolution = MAP[RANGE[ONE][THIRTY]][-> n {
	CONTROL_IF[IS_ZERO[MOD[n][FIFTEEN]]][
		FIZZBUZZ
	][CONTROL_IF[IS_ZERO[MOD[n][THREE]]][
		FIZZ
	][CONTROL_IF[IS_ZERO[MOD[n][FIVE]]][
		BUZZ
	][
		TO_DIGITS[n]
	]]]
}]
