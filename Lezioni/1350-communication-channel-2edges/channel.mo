block Channel

    InputBoolean readsignal;  
    InputBoolean writesignal;  

    InputInteger inputdata;  
    OutputInteger outputdata;

    OutputBoolean datavailable;  
    OutputBoolean spaceavailable;  

    parameter Integer N = 10;  // fifo size

    Integer fifo[N];  // fifo of input msg
    Integer oldest; 
    Integer newest; 
    Integer fifosize;

    Boolean readsigint;  
    Boolean writesigint;


    // sfrutto le equation perché mi permettono di accorgermi subito del cambio di valore di una variabile
    equation

        // diventano true quando il valore di una variabile cambia, cioè è diverso dal valore precedente
        readsigint = not(pre(readsignal) == readsignal); // monitoro quando readsignal cambia valore
        writesigint = not(pre(writesignal) == writesignal); // monitoro quando writesignal cambia valore


    algorithm

        when initial() then

            // inizializzo il canale di comunicazione

            datavailable := false;
            spaceavailable := true;
            fifosize := 0;
            oldest := 1;   // where to read
            newest := 1;   //  where to write
            outputdata := 0;
            for i in 1:N loop fifo[i] := 0; end for;

        // evento di lettura e scrittura contemporaneamente
        elsewhen (readsigint and writesigint ) then

            //assert(false, "channel: Simultaneous read and write", AssertionLevel.warning);


            if (pre(fifosize) < N)
            then
                // write
                fifo[pre(newest)] := inputdata;
                newest := mod(pre(newest), N) + 1; // mod(pre(newest) + 1 - 1, N) + 1

                //  read
                outputdata := fifo[pre(oldest)] ;
                oldest := mod(pre(oldest), N) + 1 ;

            else  // pre(fifosize) >= N
            //  read
                outputdata := fifo[pre(oldest)] ;
                oldest := mod(pre(oldest), N) + 1;
            
            // write
                fifo[pre(newest)] := inputdata;
                newest := mod(pre(newest), N) + 1; // mod(pre(newest) + 1 - 1, N) + 1

            //    fifosize := pre(fifosize) - 1;
            //    spaceavailable := true;
            //    datavailable := if (fifosize >= 1) then true else false;
            end if;

        // evento di lettura
        elsewhen (readsigint and not(writesigint) and  (pre(fifosize) >= 1) ) then

            // there is something to read

            //assert(false, "channel: Just read", AssertionLevel.warning);

                outputdata :=  fifo[pre(oldest)] ;
            
                fifosize := pre(fifosize) - 1;
                spaceavailable := true;
                datavailable := if (fifosize >= 1) then true else false;
                oldest := mod(pre(oldest), N) + 1;

        // evento di scrittura
        elsewhen (not(readsigint) and writesigint and  (pre(fifosize) < N)  ) then
            
            //assert(false, "channel: Just write", AssertionLevel.warning);


            // there is space for writing
            
                fifo[pre(newest)] := inputdata;
                newest := mod(pre(newest), N) + 1;
                fifosize := pre(fifosize) + 1;
                datavailable := true;
                spaceavailable := if (fifosize < N) then true else false;

            end when;


end Channel;