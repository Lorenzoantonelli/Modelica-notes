block Pump

       parameter Real T = 10;    // sampling time in minutes
       parameter Real MinInsulinDose = 0;
       parameter Real MaxInsulinDose = 1;


       InputReal SugarLevel; // il livello attuale di glicemia
       OutputReal InsulinDose; // dose di insulina da dare

       Real Old_SugarLevel, Old_Old_SugarLevel; // valori un sampling time indietro e due sampling time indietro
       Real Normalizing;

       algorithm

              when initial() then

                     Old_SugarLevel := 100;
                     Old_Old_SugarLevel := 100;
                     InsulinDose := 0;
                     Normalizing := 5.4;

              elsewhen sample(0, T) then


                     // Se il valore di glicemia è minore del valore precedente, vuol dire che la glicemia sta scendendo, quindi non devo dare insulina
                     if (pre(SugarLevel) <  Old_SugarLevel)  then
                     // Sugar level falling

                     InsulinDose := 0;

                     // se il valore attuale e quello precedente sono praticamente identici, non devo dare insulina
                     elseif (abs(pre(SugarLevel) - Old_SugarLevel) < 0.000001)  then
                     // Sugar level stable

                     InsulinDose := 0;

                     // se il tasso di incremento è minore rispetto al tasso di incremento precedente, non devo dare insulina
                     elseif ((pre(SugarLevel) - Old_SugarLevel) <
                            (Old_SugarLevel - Old_Old_SugarLevel))   then
                     // Sugar level increasing and rate of increase decreasing

                     InsulinDose := 0;

                     // se il rate è invece crescente, devo dare insulina
                     elseif  ((pre(SugarLevel) - Old_SugarLevel) >=
                            (Old_SugarLevel - Old_Old_SugarLevel))

                     then
                     // Sugar level increasing and rate of increase stable or increasing

                     // il massimo tra la dose minima e il rate normalizzato.
                     InsulinDose := max(MinInsulinDose,
                                   floor((pre(SugarLevel) - Old_SugarLevel)/Normalizing));


                     else
                            // qui non dovrei mai arrivare, ma per sicurezza lo metto lo stesso
                            InsulinDose := pre(InsulinDose); 

                     end if;

                     // aggiorno i valori di Old_SugarLevel e Old_Old_SugarLevel con questo campionamento
                     Old_Old_SugarLevel := Old_SugarLevel;
                     Old_SugarLevel := pre(SugarLevel);

              end when;


end Pump;