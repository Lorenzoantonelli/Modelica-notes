function  next
input TrafficLightSignal present_state;
output TrafficLightSignal next_state;

algorithm

	if (present_state == TrafficLightSignal.green) then
               next_state := TrafficLightSignal.orange;
     
	elseif (present_state == TrafficLightSignal.orange) then
     	      next_state := TrafficLightSignal.red;
     
	else  // present_state == TrafficLightSignal.red
     	       next_state := TrafficLightSignal.green;
     	end if;

end next;

