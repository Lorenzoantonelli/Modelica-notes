
function  int2bool
input Integer k;
input Integer n;
output Boolean a[n];

algorithm

       for i in 1:n loop
           if (rem(k,(2^(i))) < (2^(i-1)))
	   then
	      a[i] := false;
	   else
	      a[i] := true;	   
	   end if;
      end for;

end int2bool;

