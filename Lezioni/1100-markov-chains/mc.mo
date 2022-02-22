block MarkovChain

      parameter Integer N = 3;   // size of Markov chain (la dimensione della matrice)
      parameter Integer x_0 = 1;  // initial state MC (lo stato iniziale del nostro automa)

      parameter Real T = 1; // il clock

      output Integer x;


      // Transition Matrix MC, in Modelica le matrici quadrate si indicano con A[N, N], quelle normali con A[N, M]
      parameter Real A[N, N] =
      [
      0.2, 0.4, 0.4;
      0.4, 0.2, 0.4;
      0.4, 0.4, 0.2
      ]; // la matrice vera e propria


      algorithm

            when initial() then
                  x := x_0; // lo stato iniziale
                  
                  elsewhen sample(0,T) then

                        /*
                              Ad ogni tick tramite una funzione che si chiama pick decido se passare allo stato successivo.
                              pick prende in input un numero compreso tra 0 e 1 (che genero tramite myrandom()), lo stato in cui mi trovo e la matrice e restituisce il prossimo stato
                        */

                        x := pick(myrandom(), x, A);
            
            end when;


end MarkovChain;

