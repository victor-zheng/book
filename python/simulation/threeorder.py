import numpy as np
import matplotlib.pyplot as plt

#user input

period_step = 100  # simulation step number in one period
period_num = 1     # how many cycles you want to calculate
Vdc = 1            # bus voltage
Vref = 0.866        # regulator output the voltage reference


#generate input variable

total_step = period_step*period_num                                       #
pi_2 = 2*np.pi                                                            #const 2PI
pi_div_3 = np.pi/3                                                        #const PI/3
pi_div_6 = np.pi/6
sqrt3 = np.sqrt(3)
theta_input = np.linspace(0,pi_2*period_num,total_step,endpoint=True)     #
TA1 = np.ndarray(shape=(total_step), dtype=float)
TA2 = np.ndarray(shape=(total_step), dtype=float)
TA3 = np.ndarray(shape=(total_step), dtype=float)
TA4 = np.ndarray(shape=(total_step), dtype=float)

#calculate the alpha. it is 
if Vref <= 0.866:
    alpha = 0.0
    print('linear')
elif Vref <= 1.0:   #OVM1 range
    y = sqrt3/4 - sqrt3/2*np.sqrt(Vref*Vref - 3/4)
    x = 1 - y/sqrt3
    alpha = np.arctan(y/x)
    print('OVM 1')
else:               #OVM2 range
    y = np.sqrt(3/4*Vref*Vref - 9/16) - sqrt3/4
    x = 1 + y/sqrt3
    alpha = np.arctan(y/x)
    print('OVM 2')

#calculate output
for i in range (0,total_step):
    cycle_cnt = (int)(i/period_step)
    theta_internal = theta_input[i] - (float)(cycle_cnt)*pi_2

    T1_2 = Vref*(np.cos(theta_input[i]) - np.sin(theta_input[i])/sqrt3)
    T2_2 = Vref*(2/sqrt3)*np.sin(theta_input[i])        
    TA2[i] =+Vdc/2*T1_2 + Vdc/2*T2_2

    T1_3 = Vref*(np.cos(theta_input[i] - pi_div_3) - np.sin(theta_input[i] - pi_div_3)/sqrt3)
    T2_3 = Vref*(2/sqrt3)*np.sin(theta_input[i] - pi_div_3)      
    TA3[i] =+Vdc/2*T1_3 - Vdc/2*T2_3
    
    #sector 1
    if theta_internal < pi_div_3:       
        theta = theta_internal
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)        
        TA1[i] =+Vdc/2*T1_1 + Vdc/2*T2_1


        
    #sector 2
    elif theta_internal < 2*pi_div_3:
        theta = theta_internal - pi_div_3
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)      
        TA1[i] =+Vdc/2*T1_1 - Vdc/2*T2_1


        
    #sector 3
    elif theta_internal < 3*pi_div_3:
        theta = theta_internal - 2*pi_div_3
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)
        TA1[i] =-Vdc/2*T1_1 - Vdc/2*T2_1


            
    #sector 4
    elif theta_internal < 4*pi_div_3:
        theta = theta_internal - 3*pi_div_3
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)
        TA1[i] =-Vdc/2*T1_1 - Vdc/2*T2_1

     
    #sector 5
    elif theta_internal < 5*pi_div_3:
        theta = theta_internal - 4*pi_div_3
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)
        TA1[i] =-Vdc/2*T1_1 + Vdc/2*T2_1

    
    #sector 6
    else:                               
        theta = theta_internal - 5*pi_div_3
        T1_1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2_1 = Vref*(2/sqrt3)*np.sin(theta)
        TA1[i] =+Vdc/2*T1_1 + Vdc/2*T2_1
        
TA4 = TA2 - TA3
        
#output
plt.plot(theta_input,TA1,color='black',linewidth=1,linestyle='-')
plt.plot(theta_input,TA2,color='red',linewidth=1,linestyle='-')
plt.plot(theta_input,TA3,color='blue',linewidth=1,linestyle='-')
plt.plot(theta_input,TA4,color='green',linewidth=1,linestyle='-')
plt.grid(True, linestyle = '-', color = 'black', linewidth = '0.5')
plt.show()
