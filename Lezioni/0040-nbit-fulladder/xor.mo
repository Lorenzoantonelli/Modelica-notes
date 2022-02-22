function xor
    input Boolean a;
    input Boolean b;
    output Boolean y;

    algorithm
        y := (not(a) and b) or (a and not(b));


end xor;

