block MonitorReq1

    /*
    Req1:
    Glucose level between 50 and 150.

    */

    InputReal SugarLevel;
    OutputBoolean y;

    Boolean error;

    equation
        /*
            Sotto a 50 sono in ipoglicemia, situazione in cui non devo assolutamente arrivare perché il paziente rischia la vita.
            Anche superare i 150 è molto pericoloso.
        */
        error = (SugarLevel < 50) or (SugarLevel >= 150);


    algorithm


        when initial() then

            y := false;

        elsewhen edge(error) then

            y := true;

        end when;


end MonitorReq1;