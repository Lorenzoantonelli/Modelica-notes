block MonitorReq1

    /*
    Req1: Mutual Eclusion
    Controlla che al più un processo sia nella sezione critica
    */


    InputInteger pc[2];  // program counter of processes

    Boolean error; // error flag
    Boolean y; // il flag del monitor

    initial equation

        y = false;

    equation

        // se tutti e due i processi sono nella sezione critica, ho un errore
        error = ((pc[1] == 3) and (pc[2] == 3));

    algorithm

        // appena rilevo un errore, scatta il monitor, che non posso più far tornare a false.
        when edge(error) then
            y := true;
        end when;

end MonitorReq1;