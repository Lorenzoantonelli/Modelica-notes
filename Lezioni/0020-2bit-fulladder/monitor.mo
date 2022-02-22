class Monitor

    // il monitor prende in input tutto ciò che possiamo monitorare: ingressi e uscite del full adder

    // InputBoolean e OutputBoolean sono connettori

    InputBoolean x[2]; // i due bit in input
    InputBoolean carry_in; // il riporto in input
    InputBoolean y; 
    InputBoolean carry_out;

    OutputBoolean z; // presenza di un errore, va ad 1 se rileva un problema e resta ad 1, non scende più a 0
    Boolean w; // variabile booleana legata alla condizione di errore, va ad 1 se c'è un errore, altrimenti 0

    initial equation
        z = false;

    equation

        //  Requirements
        // Sum = A ⊕ B ⊕ Cin; Cout = (A ⋅ B) + (Cin ⋅ (A ⊕ B)).

        //  error condition

        w = (y <> xor(x[1], xor(x[2], carry_in))) or
            (carry_out <> ((x[1] and x[2]) or (carry_in and xor(x[1], x[2]))) );

        // w = (y <> xor(pre(x[1]), xor(pre(x[2]), pre(carry_in)))) or
        //    (carry_out <> (pre(x[1]) and pre(x[2])) or
        //                  (pre(carry_in) and xor(pre(x[1]), pre(x[2]))) );


    algorithm

        when edge(w) then // when edge(w) diventa true quando w passa da 0 a 1
            z := true; // z resta poi ad 1
        end when;

end Monitor;