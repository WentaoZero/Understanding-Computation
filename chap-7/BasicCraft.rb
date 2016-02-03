require "./Variable.rb"

PAIR  = -> left { -> right { -> f { f[left][right] } } }
LEFT  = -> pair { pair[-> left { -> right { left  } } ] }
RIGHT = -> pair { pair[-> left { -> right { right } } ] }

INCREMENT = -> n    { -> proc { -> x { proc[n[proc][x]] } } }
SLIDE     = -> proc { PAIR[RIGHT[proc]][INCREMENT[RIGHT[proc]]] }
DECREMENT = -> n    { LEFT[n[SLIDE][PAIR[ZERO][ZERO]]] }

ADD      = -> m { -> n { n[INCREMENT][m] } }
SUBTRACT = -> m { -> n { n[DECREMENT][m] } }
MULTIPLY = -> m { -> n { n[ADD[m]][ZERO] } }
POWER    = -> m { -> n { n[MULTIPLY[m]][ONE] } }

CONTROL_IF       = -> bool { bool }
IS_ZERO          = -> number { number[-> x { B_FALSE }][B_TRUE] }
IS_LESS_OR_EQUAL = -> left_hand { -> right_hand { IS_ZERO[SUBTRACT[left_hand][right_hand]] } }

Y_COMBINATOR = -> f { -> x { f[x[x]] }[-> x { f[x[x]] }] }
Z_COMBINATOR = -> f { -> x { f[-> y { x[x][y] }] }[-> x { f[-> y { x[x][y] }] }] }

#y = -> f { -> g { g[g] }[ -> g { f[-> args { g[g][args] }] }] }

def to_array(proc)
	array = []

	until to_boolean(IS_EMPTY[proc])
		array.push(FIRST[proc])
		proc = REST[proc]
	end

	array
end