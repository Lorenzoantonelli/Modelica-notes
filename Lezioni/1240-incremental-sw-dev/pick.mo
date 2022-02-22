
function  pick
input Real z;   // uniformly random input
input Integer x;  // present state
input Real[:,:] A;   // Transition Matrix
output Integer w;  // next state

protected
Integer i;
Real y;

algorithm


i := 1;
y := A[x, i];

while ((z > y) and (i < size(A, 1))) loop
  i := i + 1;
  y := y + A[x, i];
end while;

w := i;

end pick;


