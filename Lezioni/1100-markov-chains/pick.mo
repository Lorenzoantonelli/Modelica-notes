function  pick
  input Real z;   // uniformly random input, generato con myrandom()
  input Integer x;  // present state
  // utilizzo [:,:] per non specificare la dimensione della matrice, in modo da rendere questa funzione compatibile con matrici di qualsiasi dimensione e non solo 3x3, anche non quadrate
  input Real[:,:] A;   // Transition Matrix
  output Integer w;  // next state

  protected // con protected indico le mie variabili locali
  Integer i;
  Real y;

  algorithm
    i := 1; 
    y := A[x, i]; // inizio ad esplorare la matrice partendo da 1.

    /*
      Nel caso in cui fossi nello stato 1, assegnerei ad y inizialmente il valore 0.2, cioè il valore della matrice in posizione [1,1].
      NOTA: come per gli array, anche le matrici in modelica partono da 1 invece che da 0 come nei linguaggi di programmazione.
    */

    // size indica la dimensione della prima componente di A, il numero di righe.
    while ((z > y) and (i < size(A, 1))) loop // se z fosse 0.1 (e quindi più piccolo di 0.2), non entrerei nel while e resterei nello stato 1.
      // se z è invece maggiore di 0.2, entro nel while e incremento i, per esplorare lo stato successivo della matrice
      i := i + 1;
      y := y + A[x, i]; // aggiorno y come ho fatto nella riga 14. Quindi in questo caso avrebbe il valore della matrice in posizione [1,2], cioè 0.4 più il valore precedente, quindi 0.6 (0.2 + 0.4)
    end while;

    w := i;

    // se sono sfortunato scelgo il prossimo stato in O(n), si potrebbe fare in O(log(n))

end pick;