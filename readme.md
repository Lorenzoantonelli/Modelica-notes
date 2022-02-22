# Modelica notes

Una serie di esempi di modelli Modelica commentati. In ogni simulazione è presente un file run.sh per l'esecuzione e un file clean.sh per la pulizia dei file temporanei. Per l'esecuzione utilizziamo openmodelica.

Per eseguire le simulazioni si può anche dare il comando:
```bash
omc run.mos
```

In alcuni progetti ci sono anche dei file **readme.md** con alcuni appunti su cose dette dal Professore su quel modello.

I progetti sono numerati in ordine, quindi 0010 è il primo progetto e 3100 l'ultimo.

Per i progetti che utilizzano uno script in Python per testare i parametri è necessario installare OMPython, per farlo potete seguire la procedura descritta a [questo link](https://github.com/OpenModelica/OMPython) o lanciare il seguente comando:

```bash
python3 -m pip install -U https://github.com/OpenModelica/OMPython/archive/master.zip
```

Per visualizzare correttamente le parti in LaTeX con Visual Studio Code è necessario installare [questa estensione](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one).

# Indice argomenti
1. Basi di Modelica
   * 0010
   * 0020
   * 0040
   * 0050
   * 0105
   * 0110 
2. Risoluzione di equazioni differenziali
   * 0120
   * 0140
   * 0150
   * 0160 (con montecarlo)
   * 0170 (con montecarlo)
3. Catene di Markov e fasi
   * 1100 (introduzione alle catene di Markov)
   * 1200
   * 1240
4. Canali di comunicazione e FIFO
   * 1300
   * 1350
   * 1375
   * 2250 (include anche il program counter)
   * 2500 (include anche il program counter)
5. Automi con stati gestiti da un program counter
   * 1450
   * 2250 (include anche la FIFO)
   * 2500 (include anche la FIFO)
6. Altro
   * 3100