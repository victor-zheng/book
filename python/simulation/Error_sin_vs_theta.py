import numpy as np
import matplotlib.pyplot as plt

#input

gama = (np.pi*100)/1200.0

#calculate
theta = np.linspace(0,np.pi/3,100,endpoint=True)

T1 = np.sin(np.pi/3 - theta) / (np.sin(np.pi/3 - theta) + np.sin(theta))


T1_2 = (np.pi/3 - theta)/(np.pi/3)

print(gama)
    
#output
l1, = plt.plot(theta,T1,color='red',linewidth=1,linestyle='-')
l2, = plt.plot(theta,T1_2,color='blue',linewidth=1,linestyle='-')

plt.legend(handles = [l1, l2,], labels = ['trigonometric', 'linear'], loc = 'best')

plt.grid(True, linestyle = '-', color = 'black', linewidth = '0.5')

plt.show()
