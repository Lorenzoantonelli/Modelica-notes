class Environment

   parameter Real T = 1; // il clock

   SysParameters p; // i parametri del sistema


   // genero gli output per testare il sistema
   OutputBoolean a[p.n]; // primo operando dell'adder
   OutputBoolean b[p.n]; // secondo operando dell'adder
   OutputBoolean carry_in; // input di carry

   Integer ak, bk, ck; // servono per "spazzolare" tutte le possibili combinazioni di valori per gli input

   Boolean cin[1]; // per riutilizzare la funzione bool2int

   initial equation
      for i in 1:p.n loop
         a[i] = true;
         b[i] = true;
      end for;
      carry_in = true;

      ak = 0;
      bk = 0;
      ck = 0;

   algorithm

      when sample(0, T) then

         b := int2bool(bk, p.n); // prende un valore bk e genera un array di lunghezza p.n con bk in binario
         cin := int2bool(ck, 1); carry_in := cin[1]; // prende un valore ck e genera un array di lunghezza 1 con ck in binario
         a := int2bool(ak, p.n); // prende un valore ak e genera un array di lunghezza p.n con ak in binario

         ak := update(ak, p.n); // una funzione che prende ak, sa quanto vale n e mi restituisce il prossimo valore di ak

         /*
            ak parte da 0 e arriva a 2^n-1, per poi tornare a 0.
         */
         if (ak == 0) // appena ak torna a 0, si incrementa ck
            then
            ck := update(ck, 1);

            if (ck == 0) // appena ck torna a 0, si incrementa bk
               then
                  bk := update(bk, p.n); // una funzione che prende bk, sa quanto vale n e mi restituisce il prossimo valore di bk
            end if;  // ck
         end if; // ak

      end when;

end Environment;