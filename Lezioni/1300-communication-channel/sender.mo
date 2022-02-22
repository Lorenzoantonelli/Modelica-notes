block Sender

      parameter Integer N = 3;   // size of Markov chain
      parameter Integer x_0 = 1;  // initial state MC

      parameter Real T = 1; // il sender ha un suo clock

      InputBoolean spaceavailable;
      OutputInteger x;
      OutputBoolean writesignal;

      Integer state;

      // Transition Matrix MC
      parameter Real A[N, N] =
      [
      0.2, 0.4, 0.4;
      0.4, 0.2, 0.4;
      0.4, 0.4, 0.2
      ];


      algorithm

            when initial() then
                  x := x_0;
                  state := 0;
                  writesignal := false;
            
            elsewhen (sample(0,T) and (pre(spaceavailable) or not(state == 0))) then


                  if (pre(state) == 0) 
                  then  // prepare data
                        x := pick(myrandom(), x, A);
                        writesignal := false;
                        state := 1;
                  else //   (state == 1),  send
                        writesignal := true;
                        state := 0;
                  end if;

            /*
            then  // send data
                  writesignal := true;
                  state := 2;
                  else // (state == 2), reset trigger
                  state := 0;
                  writesignal := false;
                  end if;
            */

            end when;


end Sender;