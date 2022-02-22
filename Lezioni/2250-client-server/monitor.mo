block MonitorReq1

    /*
    Req1:
    The value value received by the client from teh server
    is the difference between the first (op1) and second (op2) operand
    the client sent to the server

    */

    parameter Real T = 0.1;

    // write side server input queue
    InputBoolean writesignal;  
    InputInteger inputdata; 


    // read side client input queue
    InputBoolean readsignal;
    InputInteger outputdata;


    Boolean old_writesignal;  
    Boolean old_readsignal;


    Integer op1, op2, value;

    Boolean error;
    Boolean y;

    Integer pc;


    algorithm


        when initial() then

            y := false;
            error := false;
            pc := 0; // program counter del monitor
            old_readsignal := false; // valori che ho visto
            old_writesignal := false; // valori che ho visto

        // il monitor deve essere molto più veloce del sistema per rilevare gli errori (T = 0.1)
        elsewhen sample(0,T) then

            // quando il valore di old_writesignal è diverso da writesignal, mi accorgo che sta arrivando il primo operando
            if (pre(pc) == 0) and not(old_writesignal == pre(writesignal)) then
                // prepare to read op1 from server input queue

                old_writesignal := pre(writesignal);
                pc := 10;

            // leggo il primo operando
            elseif (pre(pc) == 10) then
                // read op1 from server input queue

                op1 := inputdata;
                pc := 20;

            // quando il valore di old_writesignal è diverso da writesignal, mi accorgo che sta arrivando il secondo operando
            elseif (pre(pc) == 20) and not(old_writesignal == pre(writesignal)) then
                // prepare to read op2 from server input queue

                old_writesignal := pre(writesignal);
                pc := 30;

            // leggo il secondo operando
            elseif (pre(pc) == 30) then
                // read op2 from server input queue

                op2 := inputdata;
                pc := 40;

            // quando il valore di old_readsignal è diverso da readsignal, mi accorgo che sta arrivando il valore del risultato
            elseif (pre(pc) == 40) and not(old_readsignal == pre(readsignal)) then
                // prepare to read value from client input queue

                old_readsignal := pre(readsignal);
                pc := 50;

            // leggo il valore del risultato
            elseif (pre(pc) == 50) then
                // read value from client input queue and check for errors

                value := outputdata;

                // controllo che il valore calcolato sia corretto
                error := not(value == op1 - op2) ;
                y := pre(y) or error;

                // loop, il monitor riparte dall'inizi 
                pc := 0;

            else

                // se non succede nulla, rimaniamo nello stato in cui siamo e non facciamo nulla
                pc := pre(pc);

            end if;

        end when;


end MonitorReq1;