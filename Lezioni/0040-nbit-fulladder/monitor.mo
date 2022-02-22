class Monitor

  parameter Real T = 0.1;

  SysParameters p;

  InputBoolean a[p.n];
  InputBoolean b[p.n];
  InputBoolean carry_in;
  InputBoolean y[p.n];
  InputBoolean carry[p.n];
  InputBoolean carry_out;

  OutputBoolean z;

  initial equation
    z = false;

  algorithm

    //  Requirements
    // Sum = A ⊕ B ⊕ Cin; Cout = (A ⋅ B) + (Cin ⋅ (A ⊕ B)).

    //  error condition
    //    (y <> xor(a, xor(b, carry_in))) or
    //    (carry_out <> ((a and b) or (carry_in and xor(a, b))) );

    when sample(0, T) then

      if ((y[1] <> xor(a[1], xor(b[1], carry_in)))
          or
        (carry[1] <> ((a[1] and b[1]) or (carry_in and xor(a[1], b[1]))) )
        )
      then
        z := true;
      end if;

      for i in 2:p.n loop
        if ((y[i] <> xor(a[i], xor(b[i], carry[i-1]))) or
            (carry[i] <> ((a[i] and b[i]) or (carry[i-1] and xor(a[i], b[i]))) )
          )
        then
          z := true;
        end if;
      end for;

    end when;


end Monitor;
