# 1450-peterson-mutual-exclusion

Protocollo di Peterson per la mutua esclusione.

Questo algoritmo utilizza due variabili:
1. **flag**
2. **turn**

Un valore **flag[n]**, se è true indica che il processo n vuole entrare nella sezione critica. L'entrata nella sezione critica è fornito al processo $P_0$ se il processo $P_1$ non vuole entrare nella sezione critica o se il processo $P_1$ ha dato proprità a $P_0$ settando il valore di **turn** a 0.

## Esempio di codice

Innanzitutto abbiamo due variabili:

```c
bool flag[2] = {false, false};
int turn;
```

Il codice per il processo $P_0$ è:

```c
flag[0] = true;
turn = 1;
while (flag[1] && turn == 1) {
    // attendi che flag[1] sia false (busy-wait)
}
// entra nella sezione critica
// operazioni nella sezione critica
// fine della sezione critica
flag[0] = false;
```

Il codice per il processo $P_1$ è:

```c
flag[1] = true;
turn = 0;
while (flag[0] && turn == 0) {
    // attendi che flag[0] sia false (busy-wait)
}
// entra nella sezione critica
// operazioni nella sezione critica
// fine della sezione critica
flag[1] = false;
```

Questo algoritmo soddisfa i tre criteri essenziali per risolvere il problema della sezione critica. La condizione del while funziona anche con la preemption.

Posso modellare il programma come un automa. Devo quindi definire la **funzione di transizione**. La funzione di transizione prende in input lo stato corrente, l'input e restituisce lo stato successivo. La funzione di transizione è modellata in **proc.mo**.

Il program counter che viene modellato in **proc.mo** simula le istruzioni del codice di esempio per i processi $P_0$ e $P_1$.

Dobbiamo inoltre modellare uno scheduler, che abbiamo modellato in **processes.mo**, che sfrutta la funzione di transizione per scegliere il prossimo stato. Lo scheduler in questo caso sarebbe il nostro environment.

Modellando il programma come una funzione invece che come un blocco posso sfruttare lo scheduler per avere delle variabili condivise.

Abbiamo ora bisogno di un monitor, definito in **monitor.mo**.

Dopo aver fatto partire la simulazione e verificato che la condizione viene rispettata (il monitor non passa mai a 1) potrei chiedermi:
Nel file **processes.mo** ho inizializzato i valori di flag entrambi a false, i valori di pc entrambi a 0 e turn a 1. Cosa succede se turn fosse inizializzato a 2 invece che a 1? Oppure cosa succede se entrambi i valori di flag fossero inizializzati a true? Modificando entrambe queste cose il monitor rimane a 0, segno che questo algoritmo è robusto rispetto a questi cambiamenti.

Un'altra prova che posso provare a fare è cambiare la probabilità con cui i due processi vengono schedulati, visto che ora il processo 1 ha una probabilità di essere schedulato dell'80%.

Un'altro importante requisito che devo considerare è quello di non avere **starvation**. Ciò significa che se un processo chiede di entrare nella sezione critica, prima o poi dovrà essere schedulato. Creiamo quindi un secondo monitor per assicurarci che questa cosa avvenga, vedi **monitor2.mo**.