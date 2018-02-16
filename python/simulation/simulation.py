import numpy as np
import matplotlib.pyplot as plt
x=np.linspace(-np.pi,np.pi,256,endpoint=True)
C,S=np.cos(x),np.sin(x)
plt.plot(x,C)
plt.plot(x,S)
plt.plot(x,C,color='red',linewidth=2.5,linestyle='-')
plt.plot(x,S,color='blue',linewidth=2.5,linestyle='-')
plt.show()
