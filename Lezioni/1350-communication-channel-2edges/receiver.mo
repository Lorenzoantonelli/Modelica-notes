block Receiver


        parameter Real T = 2.0;

        InputBoolean datavailable;
        InputInteger data;
        OutputBoolean readsignal;

        Integer x;

        algorithm

        when initial() then
                x := 0;
                readsignal := false;
                
        elsewhen (sample(0,T) and pre(datavailable)) then

                readsignal := not(pre(readsignal)); // l'evento ora è semplicemente invertire il valore di readsignal
                x := pre(data);

        end when;


end Receiver;