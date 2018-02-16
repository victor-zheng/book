import numpy as np
import matplotlib.pyplot as plt

#input


gama = np.ndarray(shape=(20), dtype=float)
offset = np.ndarray(shape=(20), dtype=float)
offset_gain = np.ndarray(shape=(20), dtype=float)

for i in range (0,20):
    
    gama[i] = (np.pi*i)/120.0

    #calculate
    theta = np.linspace(gama[i],(np.pi/3 - gama[i]),10,endpoint=True)

    theta_asterisk = (theta - gama[i])*(np.pi/6)/(np.pi/6 - gama[i])

    T1 = np.sin(np.pi/3 - theta) / np.sin(np.pi/3 + theta)

    T1_asterisk = np.sin(np.pi/3 - theta_asterisk) / np.sin(np.pi/3 + theta_asterisk)

    gain = (np.pi/6)/(np.pi/6 - gama[i])

    T_sim = T1_asterisk/gain

    offset_array = T_sim - T1

    offset[i] = np.mean(offset_array)
    
    offset_gain[i] = offset[i]/gama[i]
    
#output
print(gama)
print(offset)
plt.plot(gama,offset_gain,color='red',linewidth=1,linestyle='-')
#plt.plot(gama,offset2,color='blue',linewidth=1,linestyle='-')
plt.show()
