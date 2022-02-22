function  full_adder // full_adder è il nome della funzione

    // elenco degli input
    input Boolean carry_in; // indica o meno la presenza del riporto
    input Boolean x[2]; // prendo in input un array di due bit, sono i due bit che riceve in input il full adder e di cui deve eseguire la sommma

    // elenco degli output
    output Boolean y; // output, un booleano
    output Boolean carry_out; // output del riporto

    /*
        Vedi:
        1. https://it.wikipedia.org/wiki/Full-adder
        2. https://it.wikipedia.org/wiki/Half-adder
    */

    algorithm
        // calcolo y e carry_out
        // la funzione xor è definita nel file xor.mo
        y :=   xor(x[1], xor(x[2], carry_in)); // y = x[1] xor x[2] xor carry_in
        carry_out := (x[1] and x[2]) or (carry_in and xor(x[1],x[2])) ; // carry_out = (x[1] and x[2]) or (carry_in and xor(x[1],x[2]))


end full_adder;