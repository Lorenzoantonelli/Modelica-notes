block Sender

      parameter Integer N = 3;   // size of Markov chain
      parameter Integer x_0 = 1;  // initial state MC

      parameter Real T = 1;

      InputBoolean spaceavailable;
      OutputInteger x;
      OutputBoolean writesignal;

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
                  writesignal := false;
                  
            elsewhen (sample(0,T) and pre(spaceavailable)) then

                  x := pick(myrandom(), pre(x), A);
                  writesignal := not(pre(writesignal)); // l'evento ora è semplicemente invertire il valore di writesignal
                  

            end when;


end Sender;