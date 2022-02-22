block Client

    parameter Real T = 2;    // clock


    // client input queue (ciq)

    // reader
    OutputBoolean readsignal; // segnale per leggere dalla coda
    InputInteger outputdata; // dato letto dalla coda
    InputBoolean datavailable; // segnale per sapere se ci sono dati nella coda  

    // server input queue (siq)

    // writer
    OutputInteger inputdata;
    OutputBoolean writesignal;
    InputBoolean spaceavailable;

    OutputInteger value;


    Integer pc; // program counter, nella pratica rappresenta gli stati in cui si trova l'automa del client

    algorithm

        when initial() then

            // inizializzo il client nello stato iniziale

            pc := 0;
            value := 0;
            readsignal := false;
            writesignal := false;

        // sample globale che mi da la velocità del client
        elsewhen sample(0,T) then

            // inverto il segnale di lettura
            if (pre(pc) == 2) and pre(datavailable) then

                assert(pre(pc) == 2, "pre(pc) == 2", AssertionLevel.warning);

                readsignal := not(pre(readsignal));
                pc := 20;

                //print("client: time = "+String(time)+"; pc="+String(pc)+"; op1-op2 = value="+String(value)+"\n");

                // elseif (pre(pc) == 20) and pre(datavailable) then

            // leggo i dati dalla coda
            elseif (pre(pc) == 20)  then

                assert(pre(pc) == 20, "pre(pc) == 20", AssertionLevel.warning);

                value := pre(outputdata);
                pc := 0;

                print("client: time = "+String(time)+"; pc="+String(pc)+"; op1-op2 = value="+String(value)+"\n");

            // scrivo i dati nella coda
            elseif (pre(pc) == 0) and pre(spaceavailable)  then
                // send

                assert(pre(pc) == 0, "pre(pc) == 0", AssertionLevel.warning);

                inputdata := User();
                pc := 30;

                // print("client: time = "+String(time)+"; pc="+String(pc)+"; op1: inputdata="+String(inputdata)+"\n");

                // elseif (pre(pc) == 30) and pre(spaceavailable)  then

            // inverto il segnale di scrittura
            elseif (pre(pc) == 30)   then
                // send

                assert(pre(pc) == 30, "pre(pc) == 30", AssertionLevel.warning);

                writesignal := not(pre(writesignal)); 
                pc := 1;

                print("client: time = "+String(time)+"; pc="+String(pc)+"; op1: inputdata="+String(inputdata)+"\n");

            // scrivo i dati nella coda
            elseif  (pre(pc) == 1) and pre(spaceavailable) then
                // send

                assert(pre(pc) == 1, "pre(pc) == 1", AssertionLevel.warning);

                inputdata := User();
                pc := 40;

                //print("client: time = "+String(time)+"; pc="+String(pc)+"; op2: inputdata="+String(inputdata)+"\n");

                // elseif  (pre(pc) == 40) and pre(spaceavailable) then

            // inverto il segnale di scrittura
            elseif  (pre(pc) == 40)  then
                // send

                assert(pre(pc) == 40, "pre(pc) == 40", AssertionLevel.warning);

                writesignal := not(pre(writesignal)); 
                pc := 2;

                print("client: time = "+String(time)+"; pc="+String(pc)+"; op2: inputdata="+String(inputdata)+"\n");

            else

                pc := pre(pc);

            end if;

        end when;


end Client;