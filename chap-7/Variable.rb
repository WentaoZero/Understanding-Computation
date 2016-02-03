ZERO  = -> proc { -> x {                          x      } }
ONE   = -> proc { -> x {                     proc[x]     } }
TWO   = -> proc { -> x {                proc[proc[x]]    } }
THREE = -> proc { -> x {           proc[proc[proc[x]]]   } }
FOUR  = -> proc { -> x {      proc[proc[proc[proc[x]]]]  } }
FIVE  = -> proc { -> x { proc[proc[proc[proc[proc[x]]]]] } }

B_TRUE  = -> _true { -> _false { _true  } }
B_FALSE = -> _true { -> _false { _false } }

def to_integer(proc)
	proc[-> n { n + 1 }][0]
end

def to_boolean(proc)
	CONTROL_IF[proc][true][false]
end
