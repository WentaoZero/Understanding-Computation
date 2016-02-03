require "./BasicCraft.rb"

EMPTY    = PAIR[B_TRUE][B_TRUE]
UNSHIFT  = -> list { -> x {
    PAIR[B_FALSE][PAIR[x][list]]
}}

IS_EMPTY = LEFT
FIRST    = -> list { LEFT[RIGHT[list]]}
REST     = -> list { RIGHT[RIGHT[list]]}

RANGE =
    Z_COMBINATOR[-> f {
        -> min { -> max {
            CONTROL_IF[IS_LESS_OR_EQUAL[min][max]][
                -> x {
                    UNSHIFT[f[INCREMENT[min]][max]][min][x]
                }
            ][
                EMPTY
            ]
        } }
    }]

=begin
COUNTDOWN = -> p { PAIR[UNSHIFT[LEFT[p]][RIGHT[p]]][DECREMENT[RIGHT[p]]] }
RANGE     = -> m { -> n { LEFT[INCREMENT[SUBTRACT[n][m]][COUNTDOWN][PAIR[EMPTY][n]]] } }
=end

FOLD =
	Z_COMBINATOR[-> f {
		-> l { -> x { -> g {
			CONTROL_IF[IS_EMPTY[l]][
				x
			][
				-> y {
					g[f[REST[l]][x][g]][FIRST[l]][y]
				}
			]
		} } }
	}]

MAP =
	-> k { -> f {
		FOLD[k][EMPTY][
			->l { -> x { UNSHIFT[l][f[x]] } }
		]
	} }

PUSH =
    -> list {
        -> x {
            FOLD[list][UNSHIFT[EMPTY][x]][UNSHIFT]
        }
    }