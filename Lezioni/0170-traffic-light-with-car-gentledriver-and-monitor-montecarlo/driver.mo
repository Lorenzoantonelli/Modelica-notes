block Driver

    parameter Real T = 0.001;  // one second

    /*
        I coefficienti a e b rappresentano quanto bruscamente il driver frena e accelera nella nostra simulazione.
        Questi valori possono essere senza problemi maggiori di 1.
    */

    parameter Real a = 1.1;  // speedup
    parameter Real b = 1.1;  // breaking



    InputTrafficLightSignal w;  

    OutputReal throttle;  
    OutputReal brake;  

    initial equation
        throttle = 0;
        brake = 0;


    algorithm

        when sample(0, T) then

            if (w == TrafficLightSignal.green)
            then
                throttle := if (throttle == 0) then 0.1 else min(1, a*throttle) ; // quando devo accelerare semplicemente modifico il valore precedente per un certo coefficiente
                brake := 0;
            else
                throttle := 0;
                brake := if (brake == 0) then 0.1 else min(1, b*brake) ;
            end if;

        end when;

end Driver;