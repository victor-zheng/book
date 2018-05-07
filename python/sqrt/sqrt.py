import numpy as np
import matplotlib.pyplot as plt

#input
var_in = 7000000
biter = 0

#calculate
if var_in <= 2097152:
    wtemproot = 128
else:
    wtemproot = 8192

while biter < 6:
    wtemprootnew = (wtemproot + var_in // wtemproot) // 2;
    if wtemprootnew == wtemproot:
        biter = 6
    else:
        biter = biter + 1
        wtemproot = wtemprootnew;
    print(biter)    
    print(wtemproot)
    
#output
var_out = wtemproot
