# 0160-traffic-light-with-car-driver-and-monitor-montecarlo

In Modelica non è possibile definire variabili statiche, come invece è possibile fare in C (vedi **myextlib.c**) per salvare lo stato precedente della funzione.

Questo esempio è importante anche perché ci mostra come utilizzare uno script in Python insieme a Modelica per fare una simulazione.

Innanzitutto bisogna ristrutturare **run.mos**.

Lo script che abbiamo visto finora è diviso in tre parti:
1. Tutte le load e caricamento dei file
2. Lancia la simulazione
3. Stampa il grafico

In questa versione invece il nostro approccio è modulare e utilizziamo invece l'istruzione **runScript**.
Dentro **load.mos** ho esattamente le stesse cose che avevo prima nei vecchi **run.mos**, quindi il caricamento dei file e le load (vedi **load.mos** e **run.mos di 0150**).

Dentro **simulate.mos** ci sono semplicemente le istruzioni per lanciare la simulazione, simulate innanzitutto compila, poi lancia la simulazione.

Infine dentro **plot.mos** ho solo le istruzioni per stampare il grafico.

Ho quindi diviso **run.mos** in diversi file, in modo da rendere modulare il tutto.

Dentro **build.mos** c'è lo script per **compilare** la simulazione senza eseguirla invece. Se dopo aver generato gli eseguibili volessi simulare, mi basterebbe solo lanciare l'eseguibile system, ma non avrei il grafico, avrei solo i risultati dentro **System_res.mat**. Per vedere correttamente i risultati nel grafico mi basta lanciare **plot.mos**.

Ricapitolando, i tre step sono:
1. Load
2. Build (ed eventualmente simulate)
3. Plot dei risultati

# Montecarlo

Grazie alla libreria OMPython, possiamo creare uno script Python che si interfaccia con Modelica. Vedi **montecarlo.py** e i commenti.
Grazie a questa libreria posso modificare i parametri di simulazione e lavorare meglio con i dati, testandolo per vedere se con i vari parametri continua a funzionare o in qualche situazione il monitor scatta a 1.
