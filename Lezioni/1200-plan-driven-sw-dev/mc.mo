block MarkovChain

      GlobalParameters p;  // p.T smapling time

      parameter Integer N = 8;   // size of Markov chain
      parameter Integer x_0 = 1;  // initial state MC

      OutputInteger x;

      Real v;

      // 1: requirement phase
      // 2: design phase
      // 3: implementation phase
      // 4: unit testing phase
      // 5: integration phase
      // 6: integration testing phase
      // 7: acceptance testing phase
      // 8: delivery

      /*
      Let p the probability of remaining in state x, thus (1-p) is the probability of leaving x.
      Let T the sampling time.
      The expected value for the soujourn time S is:
      S = (1-p)*T + p*(1-p)*2*T + p^2*(1-p)*3*T + p^3*(1-p)*4*T + ... = (1 - p)*T*\sum_{k=1}^{+\ifty} k * p^{k-1}

      Now, we observe that
      W = \sum_{k=0}^{+\ifty} p^{k} = 1/(1 - p)

      Thus,
      d W/d p = 1/(1 - p)^2

      Furthermore,
      d W/d p = \sum_{k=0}^{+\ifty} k * p^{k-1} = \sum_{k=1}^{+\ifty} k * p^{k-1}

      Thus

      S = (1 -p)*T*W = (1 -p)*T*(1/(1-p)^2) = T/(1-p)

      E.g.,
      if we want S to be 10*T then we must chose p = 9/10
      if we want S to be 20*T then we must chose p = 19/20.
      */


      // 1: requirement phase
      // 2: design phase
      // 3: implementation phase
      // 4: unit testing phase
      // 5: integration phase
      // 6: integration testing phase
      // 7: acceptance testing phase
      // 8: delivery

      // Transition Matrix MC
      parameter Real A[N, N] =
      [
      9.0/10.0, 1.0/10.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0;  
      1.0/40.0, 9.0/10.0, 3.0/40.0, 0.0, 0.0, 0.0, 0.0, 0.0;
      1.0/80.0, 1.0/80.0, 9.0/10.0, 3.0/40.0, 0.0, 0.0, 0.0, 0.0;
      1.0/120.0, 1.0/120.0, 1.0/120.0, 9.0/10.0, 3.0/40.0, 0.0, 0.0, 0.0;
      1.0/160.0, 1.0/160.0, 1.0/160.0, 1.0/160.0, 9.0/10.0, 3.0/40.0, 0.0, 0.0;
      1.0/200.0, 1.0/200.0, 1.0/200.0, 1.0/200.0, 1.0/200.0, 9.0/10.0, 3.0/40.0, 0.0;
      1.0/240.0, 1.0/240.0, 1.0/240.0, 1.0/240.0, 1.0/240.0, 1.0/240.0, 9.0/10.0, 3.0/40.0;
      1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
      ];

      // Without reworking delivery tim is:: 7*10 = 70

      algorithm

            when initial() then
                  x := x_0;

                  for i in 1:N loop
                        v := 0; for j in 1:N loop v := v + A[i, j]; end for;

                        /*
                              Utilizzo questa asserzione per garantire che uno statement sia vero, questo mi garantisce che la somma di ogni riga sia 1.
                              assert prende in input l'invariante, il messaggio in caso l'asserzione non sia corretta e il livello di asserzione.

                              Esistono due livelli:
                              1. warning
                              2. error

                              Il primo è non bloccante, mentre il secondo sì.
                        */
                        assert(abs(v  - 1.0) <= 1E-6, "Sum of Markov matrix rows is not 1", AssertionLevel.error);
                  end for;

            elsewhen sample(0, p.T) then

                  x := pick(myrandom(), x, A);
            
            end when;


end MarkovChain;