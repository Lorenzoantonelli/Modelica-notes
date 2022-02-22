block MonitorReq2
    /*
        Req2: no starvation
        Sooner or later a process gets the required resource.

        Non possiamo modellare una proprietà del genere in maniera unbounded, solo bounded,
        ciò significa che dobbiamo specificare un intervallo di tempo massimo in cui il processo deve entrare nella sezione critica 
    */
    
    parameter Real h = 20; // soglia entro il quale il processo deve avere accesso alla sezione critica

    InputInteger pc[2];

    Boolean y;
    Real time_of_request;
    Real time_of_grant;

    initial equation
        y = false;
        time_of_request = 0;
        time_of_grant = 0;

    // equation

        // error = ((time_of_grant - time_of_request) > h);

    algorithm

        when initial() then
            time_of_grant := 0;
            time_of_request := 0;

        elsewhen ((pre(pc[1]) == 1) and (pc[1] == 2)) then
            time_of_request := time;

        elsewhen ((pre(pc[1]) == 2) and (pc[1] == 3)) then
            time_of_grant := time;
            if ((time_of_grant - time_of_request) > h) then
                y := true;
            end if;

        // when edge(error) then
            // y := true;
        end when;


end MonitorReq2;