require "./Container.rb"

ZEROS = Z_COMBINATOR[-> f { UNSHIFT[f][ZERO]}]

UPWARDS_OF = Z_COMBINATOR[-> f { -> n { UNSHIFT[-> x { f[INCREMENT[n]][x] }][n] } }]

MULTIPLIES_OF =
	-> m {
		Z_COMBINATOR[-> f {
			-> n { UNSHIFT[-> x { f[ADD[m][n]][x] }][n] }
		}][m]
	}

def steam_to_array(l, count = nil)
	array = []

	until to_boolean(IS_EMPTY[l]) || count == 0
		array.push(FIRST[l])
		l = REST[l]
		count = count - 1 unless count.nil?
	end

	array
end