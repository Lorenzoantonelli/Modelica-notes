import os
import sys
import math
import numpy as np
import time
import os.path

from globalvars import num_pass, num_fail

from checkmonitors import CheckMonitors
from OMPython import OMCSessionZMQ


os.system("./mkload.sh")

omc = OMCSessionZMQ()
omc.sendExpression("getVersion()")
omc.sendExpression("cd()")
        
omc.sendExpression("runScript(\"load.mos\")")

omc.sendExpression("buildModel(System, stopTime=14400)")
#omc.sendExpression("getErrorString()")

#  begin testing

    
Num_Monitors = 2
Num_Samples = 5
Num_Parameters = 3
y =[]
p = []

# seed random number generator
np.random.seed(14793)

# init info for monitors
for k in range(Num_Monitors):
        num_pass.append(0.0) 
        num_fail.append(0.0) 
        y.append(0.0) 

#print("num_pass: "+str(num_pass)+"\n");
#print("num_fail: "+str(num_fail)+"\n");
#print("y: "+str(y)+"\n");
        
for k in range(Num_Parameters):
        p.append(0.0) 

with open ("log", 'wt') as f:
        f.write("Begin log"+"\n")
        f.flush()
        os.fsync(f)
        
with open ("output.csv", 'wt') as f:
        f.write("#Outcomes"+"\n")
        f.flush()
        os.fsync(f)

        
for i in range(Num_Samples):
#        print "Test ", i

        with open ("modelica_rand.in", 'wt') as f:
#	parameters
                p[0] = np.random.uniform(1.0, 0.001)
                p[1] = np.random.uniform(70,200)
                p[2] = np.random.uniform(4,6)
                f.write("patient.BodyRegulation="+str(p[0])+"\n"+"patient.GSetpoint="+str(p[1])+"\n"+"patient.Food2Sugar="+str(p[2])+"\n")
                f.flush()
                os.fsync(f)
        
        with open ("log", 'a') as f:
                f.write("\nTest "+str(i)+" :\n")
                f.flush()
                os.fsync(f)
        
        os.system("./System -overrideFile=modelica_rand.in >> log")
        time.sleep(1.0)         # Delay to avoid races on file re-writings. Can be dropped for non-toy examples.
# os.system("rm -f modelica_rand.in")    # .... to be on the safe side
        y[0] = omc.sendExpression("val(m1.y, 14400, \"System_res.mat\")")
        y[1] = omc.sendExpression("val(m2.y, 14400, \"System_res.mat\")")

#        print(str(i)+" "+str(y)+" "+str(p)+"\n")
        
        CheckMonitors(i, y, p,) 


