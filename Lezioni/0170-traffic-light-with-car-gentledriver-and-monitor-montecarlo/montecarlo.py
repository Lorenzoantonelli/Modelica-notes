import os
import sys
import math
import numpy as np
import time
import os.path

from OMPython import OMCSessionZMQ

# creo la sessione
omc = OMCSessionZMQ()
omc.sendExpression("getVersion()")
omc.sendExpression("cd()")

# carico i file
omc.sendExpression("runScript(\"load.mos\")")

# compilo la simulazione
omc.sendExpression("buildModel(System, stopTime=2)")
#omc.sendExpression("getErrorString()")

#  begin testing


Mass = 1500.00
MaxBreak = 1000000.00   # 700000.00
Num_Samples = 100


# seed random number generator
np.random.seed(1)

num_pass = 0
num_fail = 0
y = 0.0

with open ("log", 'wt') as f:
        f.write("Begin log"+"\n")
        f.flush()
        os.fsync(f)
        
with open ("output.txt", 'wt') as f:
        f.write("Outcomes"+"\n\n")
        f.flush()
        os.fsync(f)

for i in range(Num_Samples):
#        print "Test ", i

        with open ("modelica_rand.in", 'wt') as f:
#	20% variation of car parameters
                rand1 = Mass*np.random.uniform(0.8,1.2)
                rand2 = MaxBreak*np.random.uniform(0.8,1.2)
                rand3 = np.random.uniform(2.0,3.0) # per il freno scelgo un valore tra 2 e 3 (con un valore tra 1.1 e 2 il monitor scattava a 1 per certi parametri della macchina)
                f.write("q.Mass="+str(rand1)+"\n"+"q.MaxBreak="+str(rand2)+"\n"+"u.b="+str(rand3)+"\n")
                f.flush()
                os.fsync(f)

        with open ("log", 'a') as f:
                f.write("\nTest "+str(i)+" :\n")
                f.flush()
                os.fsync(f)
        
        os.system("./System -overrideFile=modelica_rand.in >> log")
        time.sleep(1.0)         # Delay to avoid races on file re-writings. Can be dropped for non-toy examples.
# os.system("rm -f modelica_rand.in")    # .... to be on the safe side
        y = omc.sendExpression("val(m1.z, 1.8, \"System_res.mat\")")
        os.system("rm -f System_res.mat")      # .... to be on the safe side
        
        print("Monitor value at iteration", i, ": ",  y)
        
        with open ("output.txt", 'a') as g:
                if (y <= 0.5):
                        num_pass = num_pass + 1.0
                        g.write("y["+str(i)+"] = "+str(y)+": PASS with "+"\n\t"+"Mass = "+str(rand1)+"\n\t"+"MaxBreak = "+str(rand2)+"\n\t"+"u.b = "+str(rand3)+"\n")
                else:
                        num_fail = num_fail + 1.0
                        g.write("y["+str(i)+"] = "+str(y)+": FAIL with "+"\n\t"+"Mass = "+str(rand1)+"\n\t"+"MaxBreak = "+str(rand2)+"\n\t"+"u.b = "+str(rand3)+"\n")
                g.flush()
                os.fsync(g)

print ("num pass = ", num_pass)
print ("num fail = ", num_fail)
print ("total tests = ",  num_pass + num_fail)
print ("pass prob = ", num_pass/(num_pass + num_fail))
print ("fail prob = ", num_fail/(num_pass + num_fail))