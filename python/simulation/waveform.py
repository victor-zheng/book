import numpy as np
import matplotlib.pyplot as plt

#input

gama = (np.pi*190)/1200.0

#calculate
theta = np.linspace(gama,(np.pi/3 - gama),100,endpoint=True)

theta_asterisk = (theta - gama)*(np.pi/6)/(np.pi/6 - gama)

T1 = np.sin(np.pi/3 - theta) / np.sin(np.pi/3 + theta)

T1_asterisk = np.sin(np.pi/3 - theta_asterisk) / np.sin(np.pi/3 + theta_asterisk)

gain = (np.pi/6)/(np.pi/6 - gama)
T_sim = (T1 - gama*0.955) * gain

#offset_array = T_sim - T1_asterisk

#offset = np.mean(offset_array)

#T_sim2 = T_sim - offset

print(gama)
    
#output
plt.plot(theta,T1_asterisk,color='red',linewidth=1,linestyle='-')
plt.plot(theta,T_sim,color='blue',linewidth=1,linestyle='-')
plt.show()
