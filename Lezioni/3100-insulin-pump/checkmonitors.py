import os

from globalvars import num_pass, num_fail

def CheckMonitors(i, y = [], p = []):
# y : values from monitors
# p : parameters
# i : iteration
# num_pass : number of pass
# num_pass : number of fail
# output format: total_tests_so_far parameters monitors num_pass num_fail pass_prob fail_prob
       
    print("CheckMonitors: iteration: "+str(i));
    print("CheckMonitors: parameters: "+str(p));
    print("CheckMonitors: monitors: "+str(y));

    with open ("output.csv", 'a') as g:

             # total tests
        g.write(str(i + 1)+"  ")

             # print parameters
        for k in range(len(p)):        
            g.write(str(p[k])+"  ")
             
             # print monitors
        for k in range(len(y)):
            g.write(str(y[k])+"  ")
            if (y[k] <= 0.5):
                num_pass[k] = num_pass[k] + 1.0
            else:
                num_fail[k] = num_fail[k] + 1.0


             # print num_pass
        for k in range(len(num_pass)):        
            g.write(str(num_pass[k])+"  ")

            # print num_fail
        for k in range(len(num_fail)):        
            g.write(str(num_fail[k])+"  ")


            # print pass_prob
        for k in range(len(num_pass)):
            g.write(str(num_pass[k]/(i + 1))+"  ")

                        
           # print fail_prob
        for k in range(len(num_fail)):        
            g.write(str(num_fail[k]/(i + 1))+"  ")

        g.write("\n")                       
        g.flush()
        os.fsync(g)

        print("CheckMonitors: num_pass: "+str(num_pass));
        print("CheckMonitors: num_fail: "+str(num_fail));
        print("CheckMonitors: prob_pass: "+str([x/(i + 1) for x in num_pass]));
        print("CheckMonitors: prob_fail: "+str([x/(i + 1) for x in num_fail])+"\n");


