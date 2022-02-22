function UpdateTimer

	input Integer old_counter; // il vecchio valore del contatore
	input TrafficLightSignal present_state; // lo stato attuale del semaforo
	output Integer new_counter; // il nuovo valore del contatore

	algorithm

		if (old_counter <= 0) // se il tempo di soggiorno nello stato corrente è finito
		then

			// passo al prossimo stato in base allo stato in cui mi trovo e inizializzo il nuovo contatore

			if (present_state == TrafficLightSignal.green) then
					new_counter := TimerValues.OrangeTimer;
			
			elseif (present_state == TrafficLightSignal.orange) then
					new_counter := TimerValues.RedTimer;
			
			else  // present_state == TrafficLightSignal.red
					new_counter := TimerValues.GreenTimer;
				end if;
		else // se invece il tempo di soggiorno non è ancora finito
			new_counter := old_counter - 1; // decremento semplicemente il contatore attuale
		end if;


end UpdateTimer;

