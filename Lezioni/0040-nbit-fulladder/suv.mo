class SUV

    parameter Real T = 1;

    SysParameters p; // definito in parameters.mo, per sincronizzare i parametri tra le varie classi

    InputBoolean a[p.n]; // creo un array di dimensione p.n, dove n è definito in parameters.mo
    InputBoolean b[p.n]; // il secondo input è un array di dimensione p.n, definito in parameters.mo
    InputBoolean carry_in; // il carry in input

    OutputBoolean y[p.n]; // l'output di lunghezza p.n
    OutputBoolean carry[p.n]; // l'array di resti
    OutputBoolean carry_out; // il resto finale


    algorithm

    
        when sample(0, T) then // mettiamo tutto dentro ad un clock che parte da 0 e va ad intervalli di un secondo

            // GLI INDICI DEGLI ARRAY PARTONO DA 1

            (y[1], carry[1]) := full_adder(carry_in, a[1], b[1]); // la prima volta è diverso perché prende in input il carry_in da fuori

            // grazie a questo ciclo for riempiamo l'array di output y e l'array di resti carry
            for i in 2:p.n loop // for che va da 2 a p.n, perché il primo è già fatto
                (y[i], carry[i]) := full_adder(carry[i-1], a[i], b[i]); // le altre volte invece è il resto dell'operazione precedente
            end for;

            carry_out := carry[p.n]; // il resto finale è il resto dell'ultima operazione, quindi l'ultimo elemento di carry

        end when;


end SUV;
