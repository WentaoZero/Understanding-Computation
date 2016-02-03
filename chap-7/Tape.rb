require "./Container.rb"

TAPE        = -> left { -> middle { -> right { -> blank { PAIR[PAIR[left][middle]][PAIR[right][blank]] } } } }
TAPE_LEFT   = -> tape { LEFT[LEFT[tape]]   }
TAPE_MIDDLE = -> tape { RIGHT[LEFT[tape]]  }
TAPE_RIGHT  = -> tape { LEFT[RIGHT[tape]]  }
TAPE_BLANK  = -> tape { RIGHT[RIGHT][tape] }

TAPE_WRITE = -> tape { -> char { TAPE[TAPE_LEFT[tape]][char][TAPE_RIGHT[tape]][TAPE_BLANK[tape]] } }

TAPE_MOVE_HEAD_RIGHT =
	-> tape {
		TAPE[
				PUSH[TAPE_LEFT[tape]][TAPE_MIDDLE[tape]]
			][
				CONTROL_IF[IS_EMPTY[TAPE_RIGHT[tape]]][
					TAPE_BLANK[tape]
				][
					FIRST[TAPE_RIGHT[tape]]
				]
			][
				CONTROL_IF[IS_EMPTY[TAPE_RIGHT[tape]]][
					EMPTY
				][
					REST[TAPE_RIGHT[tape]]
				]
			][
				TAPE_BLANK[tape]
			]
	}