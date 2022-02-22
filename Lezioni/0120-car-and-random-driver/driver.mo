block Driver

    parameter Real T = 0.01;  // 36 seconds, se mettessi T = 1 starei considerando un'ora

    parameter Real p = 0.5;


    OutputReal throttle;  
    OutputReal brake;  

    initial equation
        throttle = 0;
        brake = 0;


    algorithm

        when sample(0, T) then

            // con il 50% di probabilità preme l'acceleratore o il freno

            if (myrandom() <= p)
            then
                throttle := 0.5;
                brake := 0;
            else
                throttle := 0;
                brake := 0.5;
            end if;

        end when;

end Driver;