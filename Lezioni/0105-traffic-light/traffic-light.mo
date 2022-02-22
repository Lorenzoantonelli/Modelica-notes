block TrafficLight

    parameter Real T = 1; // il clock

    parameter Real p = 0.1; // la probabilità di passare allo stato successivo dell'automa

    OutputTrafficLightSignal x; // il segnale che il semaforo deve emettere

    initial equation

        x = TrafficLightSignal.green; // lo stato iniziale è verde

    algorithm

        when sample(0, T) then

            // myrandom tira fuori un numero casuale compreso tra 0 e 1
            if (myrandom() <= p) // con probabilità 0.1 passo allo stato successivo
            then
                /*
                    Il pre(x) indica il valore che x aveva al sample precedente, quindi il valore che aveva prima di questo sample.
                    In realtà in questo caso funzionerebbe anche con x := next(x), ma in altri casi è fondamentale metterlo.
                    x := next(pre(x));
                */
            end if;

        end when;

end TrafficLight;
