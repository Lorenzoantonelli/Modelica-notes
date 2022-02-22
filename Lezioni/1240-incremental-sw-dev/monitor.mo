
block Monitor1


      // GlobalParameters p;

      InputInteger x ;  // sw dev state, 0 when delivering
      OutputReal y;    // expected time to complete sw development
      OutputInteger counter;    // expected time to complete sw development

      Boolean delivery;

      initial equation
      counter = 0;
      y = 0;

      equation

      delivery = (x == 0);

      algorithm

      when edge(delivery)  then

            counter := counter + 1;
            y := time/counter;

      end when;



end Monitor1;