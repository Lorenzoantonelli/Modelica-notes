function  next

     // funzione di transizione per l'automa del semaforo, dallo stato corrente restituisce lo stato successivo

     input TrafficLightSignal present_state; // lo stato corrente del semaforo
     output TrafficLightSignal next_state; // lo stato successivo del semaforo

     algorithm

          if (present_state == TrafficLightSignal.green) then // se il semaforo è verde
               next_state := TrafficLightSignal.orange; // il semaforo diventa arancione
               
          elseif (present_state == TrafficLightSignal.orange) then // se il semaforo è arancione
               next_state := TrafficLightSignal.red; // il semaforo diventa rosso
               
          else  // present_state == TrafficLightSignal.red (se il semaforo è rosso)
               next_state := TrafficLightSignal.green; // il semaforo diventa verde
               
          end if;

end next;