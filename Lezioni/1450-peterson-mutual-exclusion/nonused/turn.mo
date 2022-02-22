

block Turnp

Integer state   // state of process 

Boolean mktrans;

equation

mktrans = (sck == PID);

algorithm

when initial() then

// define initial state 
state := 0

elsewhen ( edge(mktrans) ) then
// process moves

state := next(pre(state[i]));

end when;


end Turn;