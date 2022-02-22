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
    Integer fifosize; // quanti messaggi ho nella coda


    algorithm

        when initial() then

            datavailable := false;
            spaceavailable := true;
            fifosize := 0;
            oldest := 1;   // where to read
            newest := 1;   //  where to write
            outputdata := 0;
            for i in 1:N loop 
                fifo[i] := 0;
            end for;

        elsewhen (edge(readsignal) and edge(writesignal) ) then

            // assert(false, "Simultaneous read and write", AssertionLevel.warning);

            // se ho spazio per scrivere
            if (pre(fifosize) < N)
            then
                // write
                fifo[newest] := inputdata;
                newest := mod(pre(newest), N) + 1; // mod(pre(newest) + 1 - 1, N) + 1

                //  read
                outputdata := fifo[pre(oldest)] ;
                oldest := mod(pre(oldest), N) + 1 ;

            else  // we can only read, pre(fifosize) == N
                outputdata := fifo[pre(oldest)] ;
            
                
                fifosize := pre(fifosize) - 1;
                oldest := mod(pre(oldest), N) + 1;
                spaceavailable := true;
                datavailable := if (fifosize >= 1) then true else false;
            end if;

        // leggo solo
        elsewhen (edge(readsignal) and not(edge(writesignal)) and  (pre(fifosize) >= 1) ) then

            // assert(false, "edge(readsignal) and not(edge(writesignal)", AssertionLevel.warning);

            // there is something to read

            outputdata := fifo[pre(oldest)] ;
        
            fifosize := pre(fifosize) - 1;
            spaceavailable := true;
            datavailable := if (fifosize >= 1) then true else false;
            oldest := mod(pre(oldest), N) + 1;

        // scrivo solo
        elsewhen (not(edge(readsignal)) and edge(writesignal) and  (pre(fifosize) < N)  ) then
            
            // there is space for writing
        
            fifo[newest] := inputdata;
            newest := mod(pre(newest), N) + 1;
            fifosize := pre(fifosize) + 1;
            datavailable := true;
            spaceavailable := if (fifosize < N) then true else false;

        end when;


end Channel;