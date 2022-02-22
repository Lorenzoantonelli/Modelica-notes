block TrafficLight

     parameter Real T = 1; // il clock
     parameter Real SwitchProbability = 0.1; // la probabilità di passare allo stato successivo, se fosse 1 cambierei stato ad ogni colpo di clock

     TimerValues p;

     OutputTrafficLightSignal x;

     Integer counter;

     initial equation

          // inizializzo il semaforo a verde

          x = TrafficLightSignal.green;
          counter = p.GreenTimer;

     algorithm

          when (sample(0, T) and ((myrandom() <= SwitchProbability))) then

               if (counter <= 0)
               then
                    x := next(pre(x));
               end if;

               counter := UpdateTimer(counter, pre(x));


          end when;

end TrafficLight;
