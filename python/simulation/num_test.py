import numpy as np
import matplotlib.pyplot as plt

gama = np.pi/12

theta = np.linspace(gama,(np.pi/3 - gama),10,endpoint=True)

theta_asterisk = (theta - gama)*(np.pi/6)/(np.pi/6 - gama)

T1 = np.sin(np.pi/3 - theta) / np.sin(np.pi/3 + theta)

T1_asterisk = np.sin(np.pi/3 - theta_asterisk) / np.sin(np.pi/3 + theta_asterisk)

#plt.plot(theta,T1,color='red',linewidth=1,linestyle='-')
plt.plot(theta,T1_asterisk/T1,color='blue',linewidth=1,linestyle='-')
plt.show()
