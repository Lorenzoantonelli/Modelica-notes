# 0110-traffic-light

A differenza di 0105 qui ho la scelta sui tempi di soggiorno in uno stato del semaforo.

Il tipo enumerativo (**types.mo**) è sempre lo stesso, così come la funzione next, definita in **next.mo**.

Una importante differenza è la funzione updateTimer, definita in **update.mo**, che aggiorna il semaforo sulla base di un contatore che viene decrementato. Il tempo di soggiorno in ogni stato è settato nel file **constants.mo**.