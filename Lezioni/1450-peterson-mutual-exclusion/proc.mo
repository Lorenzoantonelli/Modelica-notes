function Proc

      // modella il programma istruzione per istruzione, grazie al program counter

      input Integer pid;   //1 or 2, il PID del processo
      input Integer old_pc; // il program counter
      input Boolean old_flag;   // flag[pid], non è un array perché ogni processo ha il suo flag e basta
      input Integer old_turn;   // turn, il flag dell'altro processo
      input Boolean prg_input;  // flag[3 - pid]
      output Integer new_pc; // nuovo valore per il program counter
      output Boolean new_flag; // nuovo valore per il flag
      output Integer new_turn; // nuovo valore per il turn

      algorithm

            // inizializzo i nuovi valori come i vecchi (cosa non sottointesa in un automa)
            new_pc := old_pc;
            new_turn := old_turn;
            new_flag := old_flag;

            if (old_pc == 0) // sono nella riga iniziale del programma, devo quindi settare il mio flag a true
            then
                  new_flag := true;   // true: want to enter critical section
                  new_pc := 1; // passo alla locazione successiva (seconda riga del codice, vedi readme.md)

            elseif (old_pc == 1)
            then
                  new_turn := 3 - pid;  // it is not my turn.
                  /*
                        Dato che in Modelica gli array sono indicizzati da 1, faccio 3 - pid per ottenere il pid dell'altro processo:
                        
                        Se sono il pid 1, allora 3 - pid = 2, quindi il turno è del processo 2.
                        Se sono il pid 2, allora 3 - pid = 1, quindi il turno è del processo 1.
                  */
                  new_pc := 2; // vado alla riga successiva

            elseif (old_pc == 2) // questa locazione è quella del while
            then
                  /*
                        Vado a vedere se il program input dell'altro (che leggo solo) è diventato true.
                        Se è true e non è il mio turno faccio busy waiting settando il program counter di nuovo a 2.
                        Altrimenti lo setto a 3 e vado alla riga successiva.
                  */
                  if ( (prg_input)    // other process wants to enter
                        and
                        (old_turn == 3 - pid)       // it is not my turn
                        )
                  then 
                        new_pc := 2;  // busy waiting
                  else
                        new_pc := 3; // enter critical section
                  end if;

            elseif (old_pc == 3) // parte della sezione critica
            then
                  if (myrandom() <= 0.5) // con il 50% di probabilità esco dalla sezione critica
                  then
                        new_pc := 3;  // stay in critical section
                  else
                        new_pc := 4;  // leave critical section
                  end if;

            elseif (old_pc == 4) //  esco dalla sezione critica
            then
                  new_flag := false; // rimetto il flag a false
                  new_pc := 0;   // infinite loop, ritorno all'inizio del program counter
            else  // old_pc > 4 out of range
                  new_pc := 0;   // infinite loop
            end if;

end Proc;