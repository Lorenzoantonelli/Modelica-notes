class Monitor2

parameter Real T = 0.1;

SysParameters p;

InputBoolean a[p.n];
InputBoolean b[p.n];
InputBoolean carry_in;
InputBoolean y[p.n];
InputBoolean carry[p.n];
InputBoolean carry_out;

OutputBoolean z;

Integer A, B, Sum;

Boolean S[p.n + 1];

initial equation
z = false;

algorithm


when sample(0, T) then

if (carry_in) 
then
  A := bool2int(a)+1;
else
  A := bool2int(a);
end if;

B := bool2int(b);

for i in 1:p.n loop
S[i] := y[i];
end for;
S[p.n + 1] := carry_out;
Sum := bool2int(S);


if (Sum <> A + B)
then
  z:= true;
end if;

end when;


end Monitor2;
