block Monitor1

  InputTrafficLightSignal w;  

  InputReal CarSpeed;  
  OutputBoolean z;

  Boolean error;

  initial equation
    // inizializzo il flag di errore a false
    z = false;


  // Req: if traffic light is red then car speed shall be 0.

  equation
    // error = (TrafficLightSignal.red == w) and (CarSpeed <> 0) ;
    // se il semaforo è rosso e la mia velocità non è zero
    error = (TrafficLightSignal.red == w) and (abs(CarSpeed) > 1E-2) ;


  algorithm

    when edge(error) then
      z := true;
    end when;

end Monitor1;