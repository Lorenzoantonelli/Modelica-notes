class Environment // l'ambiente ha il compito di generare gli input per il modello

  // concettualmente dovrei generare tutti i possibili input, per questo esempio sono i seguenti: 00 01 10 11 più il carry in
  // se non può generare tutti gli input, deve almeno generare gli input "ostili"

  parameter Real T = 1; // intervallo di tempo tra un sample e l'altro

  OutputBoolean x[2]; // i due bit di output
  OutputBoolean carry_in; // il bit di carry in

  initial equation

    // inizializzo tutto a true

    x[1] = true; // inizializzo il primo bit di output a 1
    x[2] = true; // inizializzo il secondo bit di output a 1
    carry_in = true; // inizializzo il riporto a 1

  algorithm

    // il carry in
    when sample(0, T) then // ogni T secondi
      carry_in := not(carry_in); // inverto il bit del riporto
    end when;

    // il bit meno significativo
    when sample(0, 2*T) then // ogni 2*T secondi
      x[1] := not(x[1]); // inverto il primo bit di output
    end when;

    // il bit più significativo
    when sample(0, 4*T) then // ogni 4*T secondi
      x[2] := not(x[2]); // inverto il secondo bit di output
    end when;

end Environment;