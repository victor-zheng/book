import numpy as np
import matplotlib.pyplot as plt

#user input

period_step = 100  # simulation step number in one period
period_num = 2     # how many cycles you want to calculate
Vdc = 1            # bus voltage
Vref = 0.7         # regulator output the voltage reference


#generate input variable

total_step = period_step*period_num                                       #
pi_2 = 2*np.pi                                                            #const 2PI
pi_div_3 = np.pi/3                                                        #const PI/3
sqrt3 = np.sqrt(3)
theta_input = np.linspace(0,pi_2*period_num,total_step,endpoint=True)     #
TA = np.ndarray(shape=(total_step), dtype=float)
TB = np.ndarray(shape=(total_step), dtype=float)
TC = np.ndarray(shape=(total_step), dtype=float)

#calculate

for i in range (0,total_step):
    cycle_cnt = (int)(i/period_step)
    theta_internal = theta_input[i] - (float)(cycle_cnt)*pi_2
    
    #sector 1
    if theta_internal < pi_div_3:       
        theta = theta_internal
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =+Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 - Vdc/2*T2
        
    #sector 2
    elif theta_internal < 2*pi_div_3:
        theta = theta_internal - pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =+Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 - Vdc/2*T2       

    #sector 3
    elif theta_internal < 3*pi_div_3:
        theta = theta_internal - 2*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =-Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 + Vdc/2*T2

    #sector 4
    elif theta_internal < 4*pi_div_3:
        theta = theta_internal - 3*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =-Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 + Vdc/2*T2
        
    #sector 5
    elif theta_internal < 5*pi_div_3:
        theta = theta_internal - 4*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =-Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 + Vdc/2*T2

    #sector 6
    else:                               
        theta = theta_internal - 5*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        
        TA[i] =+Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 - Vdc/2*T2
            
#output
plt.plot(theta_input,TA,color='red',linewidth=1,linestyle='-')
plt.plot(theta_input,TB,color='blue',linewidth=1,linestyle='-')
plt.plot(theta_input,TC,color='green',linewidth=1,linestyle='-')
plt.show()
