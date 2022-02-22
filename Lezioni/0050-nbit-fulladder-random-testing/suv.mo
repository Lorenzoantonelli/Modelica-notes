class SUV

parameter Real T = 1;

SysParameters p;

InputBoolean a[p.n];
InputBoolean b[p.n];
InputBoolean carry_in;
OutputBoolean y[p.n];
OutputBoolean carry[p.n];
OutputBoolean carry_out;


algorithm

 
when sample(0, T) then

(y[1], carry[1]) := full_adder(carry_in, a[1], b[1]);

for i in 2:p.n loop
(y[i], carry[i]) := full_adder(carry[i-1], a[i], b[i]);
end for;

carry_out := carry[p.n];

end when;


end SUV;
