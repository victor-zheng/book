import numpy as np
import matplotlib.pyplot as plt

#input

gama = (np.pi*10)/1200.0

#calculate
theta = np.linspace(gama,(np.pi/3 - gama),100,endpoint=True)

theta_asterisk = (theta - gama)*(np.pi/6)/(np.pi/6 - gama)

T1 = np.sin(np.pi/3 - theta) / np.sin(np.pi/3 + theta)

T1_error = 1 - (np.sin(np.pi/3 - gama) / np.sin(np.pi/3 + gama))

T1_asterisk = np.sin(np.pi/3 - theta_asterisk) / np.sin(np.pi/3 + theta_asterisk)
T1_2 = (T1 - T1_error)
gain_2 = np.divide(T1_asterisk, T1_2)
gain = (np.pi/6)/(np.pi/6 - gama)
T_sim = (T1 - T1_error) * gain*1.07
T1_2 = (T1 - T1_error)
T_sim_2 = (T1 - gama*0.955)* gain
gain_ave = np.mean(gain_2)
print(gain_2)
print(gain_ave)    
#output
plt.plot(theta,T1_asterisk,color='red',linewidth=1,linestyle='-')
plt.plot(theta,T_sim,color='blue',linewidth=1,linestyle='-')
plt.plot(theta,T_sim_2,color='green',linewidth=1,linestyle='-')
plt.plot(theta,T1_2,color='black',linewidth=1,linestyle='-')

plt.grid(True, linestyle = '-', color = "black", linewidth = "1") 
plt.show()
