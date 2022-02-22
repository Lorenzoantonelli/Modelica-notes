block Driver

    parameter Real T = 0.01; // 36 secondi

    parameter Real p = 0.5;


    InputTrafficLightSignal w;  

    OutputReal throttle;  
    OutputReal brake;  

    initial equation
        throttle = 0;
        brake = 0;


    algorithm

        when sample(0, T) then

            if (w == TrafficLightSignal.green) // se il semaforo è verde
            then
                throttle := 0.5; // accelera a 0.5
                brake := 0;
            else // se il semaforo è rosso o giallo
                throttle := 0;
                brake := 0.5; // frena a 0.5
            end if;

        end when;

end Driver;