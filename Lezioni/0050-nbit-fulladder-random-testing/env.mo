class Environment

   parameter Real T = 1;

   SysParameters p;

   OutputBoolean a[p.n];
   OutputBoolean b[p.n];
   OutputBoolean carry_in;

   initial equation
      for i in 1:p.n loop
         a[i] = true;
         b[i] = true;
      end for;
      carry_in = true;


   algorithm

      when sample(0, T) then

         for i in 1:p.n loop
            a[i] := if (myrandom() <= 0.5) then true else false; // per assegnare il valore sfrutto myrandom e con il 50% di probabilità avrò true
            b[i] := if (myrandom() <= 0.5) then true else false; // per assegnare il valore sfrutto myrandom e con il 50% di probabilità avrò true
         end for;
         carry_in := if (myrandom() <= 0.5) then true else false; // per assegnare il valore sfrutto myrandom e con il 50% di probabilità avrò true

      end when;

end Environment;
