class System // avrei anche potuto scrivere model System, o anche block, con la differenza che un block ha degli input e degli output

    parameter Real T = 1 "Time interval for sample"; // lo uso per dare il mio clock
    // un parametro non cambia durante l'esecuzione del programma, una variabile cambia

    // in C i parametri vengono tradotti come delle DEFINE

    Boolean x "The value that is being monitored"; 

    // in ogni istante di tempo modelica vuole che le variabili siano definite

    initial equation // ciò che è vero al tempo zero, la fase di inizializzazione

        x = false; // x is initially false

/*
    Modelica ha due modi per definire il comportamento: tramite algoritmi o tramite equazioni
    Un algoritmo è come nei linguaggi di programmazione
    Le equazioni invece devono valere tutte, indipendentemente dall'ordine, sono utilizzate nel sistema cyber-fisico
*/

    algorithm

        when sample(0, T) then // every T seconds x is set to the opposite value, so at time 0, x is false, at time T, x is true, and so on

        //  significa sostanzialmente: da zero, ogni T secondi, esegui la seguente istruzione. La logica è che voglio progettare un software che viene chiamato ogni T secondi.
        //  in sostanza genera un true ogni T secondi

            x := not(x); // assegnazione

        end when;

end System;