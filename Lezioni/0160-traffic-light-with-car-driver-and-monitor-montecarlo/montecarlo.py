import os
import sys
import math
import numpy as np
import time
import os.path

from OMPython import OMCSessionZMQ # questa libreria permette a Python di interfacciarsi con Modelica


omc = OMCSessionZMQ() # apro la connessione con OpenModelica

# le successive due istruzioni sono per debugging
omc.sendExpression("getVersion()")
omc.sendExpression("cd()")

# carico i file, utilizzo la funzione runScript che permette di caricare load.mos in Modelica
omc.sendExpression("runScript(\"load.mos\")")

# compilo
omc.sendExpression("buildModel(System, stopTime=2)")
#omc.sendExpression("getErrorString()")

#  begin testing
Mass = 1500.00
MaxBreak = 700000.00
Num_Samples = 10 # numero di campioni, più è grande più siamo sicuri che non ci siano errori, ma maggiore è anche il tempo di esecuzione


# seed random number generator
np.random.seed(1)

num_pass = 0
num_fail = 0
y = 0.0

with open ("log", 'wt') as f: # utile per il debug
        f.write("Begin log"+"\n")
        f.flush()
        os.fsync(f)
        
with open ("output.txt", 'wt') as f: # importante per vedere l'esito dei test
        f.write("Outcomes"+"\n\n")
        f.flush()
        os.fsync(f)

# faccio Num_Samples simulazioni, ma invece che usare i parametri nel modello, uso i parametri che scelgo, messi in modelica_rand.in
for i in range(Num_Samples):
#        print "Test ", i

        with open ("modelica_rand.in", 'wt') as f:
#	20% variation of car parameters
                rand1 = Mass*np.random.uniform(0.8,1.2)
                rand2 = MaxBreak*np.random.uniform(0.8,1.2)
                f.write("q.Mass="+str(rand1)+"\n"+"q.MaxBreak="+str(rand2)+"\n")
                f.flush()
                os.fsync(f) # bisogna forzare la sincronizzazione con il filesystem, perché Python si prende delle libertà e non si sa mai

        with open ("log", 'a') as f:
                f.write("\nTest "+str(i)+" :\n")
                f.flush()
                os.fsync(f)
        
        os.system("./System -overrideFile=modelica_rand.in >> log") # esegue il modello compilato con i parametri scelti
        time.sleep(1.0)         # Delay to avoid races on file re-writings. Can be dropped for non-toy examples.
# os.system("rm -f modelica_rand.in")    # .... to be on the safe side

        y = omc.sendExpression("val(m1.z, 1.8, \"System_res.mat\")") # val ci permette di leggere il monitor. Prende in input una variabile, in questo caso m1.z, cioè il monitor e il file che contiene i risultati della simulazione

        os.system("rm -f System_res.mat")      # .... to be on the safe side
        
        print("Monitor value at iteration", i, ": ",  y) # per motivi di debug, non è necessario
        
        # aggiorno il file di output
        with open ("output.txt", 'a') as g:
                if (y <= 0.5):
                        num_pass = num_pass + 1.0
                        g.write("y["+str(i)+"] = "+str(y)+": PASS with "+"\n\t"+"Mass = "+str(rand1)+"\n\t"+"MaxBreak = "+str(rand2)+"\n")
                else:
                        num_fail = num_fail + 1.0
                        g.write("y["+str(i)+"] = "+str(y)+": FAIL with "+"\n\t"+"Mass = "+str(rand1)+"\n\t"+"MaxBreak = "+str(rand2)+"\n")
                g.flush()
                os.fsync(g)

# stampo un po' di statistiche
print ("num pass = ", num_pass)
print ("num fail = ", num_fail)
print ("total tests = ",  num_pass + num_fail)
print ("pass prob = ", num_pass/(num_pass + num_fail))
print ("fail prob = ", num_fail/(num_pass + num_fail))