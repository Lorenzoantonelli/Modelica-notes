function  int2bool
input Integer k;
input Integer n;
output Boolean a[n];

/*
	Converte un numero intero in un array di booleani, che rappresentano il numero intero in binario.
	prendo il numero, lo divido per due, se viene restituito un numero pari, metto true nell'array di booleani, altrimenti metto false.
	Procedo poi con 4 e poi con 8 e cosi' via.
*/


algorithm
       for i in 1:n loop
           if (rem(k,(2^(i))) < (2^(i-1))) // rem è remainder, restituisce il resto della divisione
	   then
	      a[i] := false;
	   else
	      a[i] := true;	   
	   end if;
      end for;

end int2bool;

