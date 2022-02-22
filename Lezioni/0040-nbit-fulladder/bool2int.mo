function  bool2int
input Boolean a[:];
output Integer k;

/*
    Questa funzione prende in input un array di booleani che rappresenta un numero in binario e restituisce un intero.
    L'intero fornito in output è il numero intero corrispondente.
*/

algorithm

k := 0;

for i in 1:size(a,1) loop
    if (a[i])
       then
	   k := k + integer(2^(i - 1));
    end if;
end for;



end bool2int;