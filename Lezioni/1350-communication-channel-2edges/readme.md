# 1350-communication-channel-2edges

Nell'esempio precedente (1300) abbiamo visto una simulazione di tipo **event based**, diversa dalle precedenti simulazioni che erano **event based**. Il canale di comunicazione era una coda FIFO. Abbiamo quindi introdotto un segnale che insieme al dato creasse l'evento.

Cosa non ci piace del canale di comunicazione precedentemente implementato? Il fatto che mandiamo solo quando l'edge è positiva, cioè quando writesignal passa da 0 a 1 e sprechiamo completamente il tempo del writesignal che passa da 1 a 0.

Vogliamo quindi creare un canale di comunicazione che si muove su tutti e due i fronti.

Nella nuova implementazione del sender in **sender.mo** l'evento che genero quando ho spazio disponibile non è più il passaggio del writesignal da 0 a 1, ma è l'inversione del valore corrente del writesignal.

Applico poi lo stesso concetto anche al receiver in **receiver.mo**. L'evento sarà quindi la semplice inversione di readsignal.

In questo modo non spreco del tempo.

L'evento quindi non è più l'edge ma il cambio di valore, devo quindi modificare opportunamente il canale di comunicazione in **channel.mo**.

Il file **mkload.sh** crea un file load.mos prendendo tutti i file **.mo**. A questo punto potrei chiamare questo script con:

```bash
./mkload.sh
```

A questo punto posso anche creare uno script che prima chiama **mkload.sh** e poi lancia il simulatore. Vedi **run.sh**.

Mi basterà quindi lanciare **run.sh** con

```bash
./run.sh
```

