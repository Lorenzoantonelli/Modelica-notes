block Processes

    parameter Real T = 1;    // clock

    // scheduler
    Integer pid;  // pid = 1, 2 of process that should move (schedulator)

    // shared variables
    Boolean flag[2];  // shared variable
    Integer turn;   // shared variable
    OutputInteger pc[2];   // program counter processes


    algorithm

        when initial() then

            // definisco lo stato iniziale, dove nessun processo vuole entrare nella sezione critica e sono all'inizio
            flag[1] := false;
            flag[2] := false;
            pc[1] := 0;
            pc[2] := 0;
            turn := 1;

        elsewhen ( sample(0, T) ) then
            // process moves

            /*
                Decide which process moves (schedulator).

                Con l'80% di probabilità il processo 1 richiederà l'accesso alla sezione critica, con il 20% il processo 2.
            */
            pid := if (myrandom() <= 0.8) then 1 else 2;

            // devo usare il pre nelle chiamate a Proc perché mi interessa il valore prima di questo colpo di clock.
            if (pid == 1)
            then
                // Il processo 1 richiede l'accesso alla sezione critica
                (pc[1], flag[1], turn) := Proc(1, pre(pc[1]), pre(flag[1]), pre(turn), pre(flag[2]));
            else
                // Il processo 2 richiede l'accesso alla sezione critica
                (pc[2], flag[2], turn) := Proc(2, pre(pc[2]), pre(flag[2]), pre(turn), pre(flag[1]));
            end if;

        end when;


end Processes;