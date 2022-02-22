function UpdateTimer

input Integer old_counter;
input TrafficLightSignal present_state;
output Integer new_counter;

algorithm

if (old_counter <= 0)
then
	if (present_state == TrafficLightSignal.green) then
               new_counter := TimerValues.OrangeTimer;
     
	elseif (present_state == TrafficLightSignal.orange) then
     	      new_counter := TimerValues.RedTimer;
     
	else  // present_state == TrafficLightSignal.red
     	       new_counter := TimerValues.GreenTimer;
     	end if;
else
   new_counter := old_counter - 1;
end if;


end UpdateTimer;

