function  full_adder

    // Il full adder è lo stesso del modello a 2 bit (0020)

    input Boolean carry_in;
    input Boolean a;
    input Boolean b;
    output Boolean s;
    output Boolean carry_out;

    algorithm
        s :=   xor(a, xor(b, carry_in));

        carry_out := (a and b) or (carry_in and xor(a, b)) ;


end full_adder;

