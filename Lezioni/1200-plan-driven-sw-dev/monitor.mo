block Monitor1


  // GlobalParameters p;

  InputInteger x ;  // sw dev state
  OutputReal y;    // expected time to complete sw development
  OutputInteger counter;    // num deliveries

  Boolean delivery;

  initial equation
  counter = 0; // aumenta di 1 ogni volta che ho una delivery
  y = 0;

  equation
    // uso una equation perché mi devo accorgere immediatamente che x è diventato 8

    delivery = (x == 8); // il software è completo quando arrivo allo stato 8 della catena di Markov

  algorithm

    // quando la delivery passa da 0 a 1, guardo quanto tempo è trascorso e modifico i contatori, per calcolare il tempo medio
    when edge(delivery)  then

          counter := counter + 1;
          y := time/counter;

    end when;


  /*
  algorithm
  
  // non uso questo approccio perché rischio di contare più volte lo stesso evento "x arriva ad 8"
  when sample(0, p.T) then

    if (x == 8)
    then
        counter := counter + 1;
        y := time/counter;
    end if;
        
  end when;
  */


end Monitor1;