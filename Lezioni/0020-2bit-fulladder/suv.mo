class SUV

    // serve in sostanza per alimentare il full adder

    parameter Real T = 1;

    InputBoolean x[2]; // i due input del full adder
    InputBoolean carry_in;
    OutputBoolean y;
    OutputBoolean carry_out;

    algorithm

    
    when sample(0, T) then

        (y, carry_out) := full_adder(carry_in, x); // full_adder mi da come risultati y e carry_out, così li assegno contemporaneamente

    end when;

end SUV;