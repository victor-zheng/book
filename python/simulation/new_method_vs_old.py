import numpy as np
import matplotlib.pyplot as plt

#user input

period_step = 100  # simulation step number in one period
period_num = 2     # how many cycles you want to calculate
Vdc = 1            # bus voltage
Vref = 1.4        # regulator output the voltage reference


#generate input variable

total_step = period_step*period_num                                       #
pi_2 = 2*np.pi                                                            #const 2PI
pi_div_3 = np.pi/3                                                        #const PI/3
pi_div_6 = np.pi/6
sqrt3 = np.sqrt(3)
theta_input = np.linspace(0,pi_2*period_num,total_step,endpoint=True)     #
TA = np.ndarray(shape=(total_step), dtype=float)
TB = np.ndarray(shape=(total_step), dtype=float)
TC = np.ndarray(shape=(total_step), dtype=float)

TA_new = np.ndarray(shape=(total_step), dtype=float)
TB_new = np.ndarray(shape=(total_step), dtype=float)
TC_new = np.ndarray(shape=(total_step), dtype=float)

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
    gain = pi_div_6/(pi_div_6 - alpha)
    offset = alpha * 0.955
    print('OVM 2')

#calculate output
for i in range (0,total_step):
    cycle_cnt = (int)(i/period_step)
    theta_internal = theta_input[i] - (float)(cycle_cnt)*pi_2
    
    #sector 1
    if theta_internal < pi_div_3:       
        theta = theta_internal
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2

        if Vref <= 0.866:                 #linear range
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:                 #OVM1 range
            if T1_T2 > 1.0:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:                             #OVM2 range
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            
        TA[i] =+Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 - Vdc/2*T2

        TA_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        TB_new[i] =-Vdc/2*T1_new + Vdc/2*T2_new
        TC_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        
    #sector 2
    elif theta_internal < 2*pi_div_3:
        theta = theta_internal - pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2
        
        if Vref <= 0.866:
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:
            if T1_T2 > 1:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2    
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2    
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            
        TA[i] =+Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 - Vdc/2*T2

        TA_new[i] =+Vdc/2*T1_new - Vdc/2*T2_new
        TB_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        TC_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        
    #sector 3
    elif theta_internal < 3*pi_div_3:
        theta = theta_internal - 2*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2
        
        if Vref <= 0.866:
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:
            if T1_T2 > 1:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2  
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2  
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2

        TA[i] =-Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 + Vdc/2*T2
        TC[i] =-Vdc/2*T1 + Vdc/2*T2

        TA_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        TB_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        TC_new[i] =-Vdc/2*T1_new + Vdc/2*T2_new
            
    #sector 4
    elif theta_internal < 4*pi_div_3:
        theta = theta_internal - 3*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2
        
        if Vref <= 0.866:
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:
            if T1_T2 > 1:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2

        TA[i] =-Vdc/2*T1 - Vdc/2*T2
        TB[i] =+Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 + Vdc/2*T2
        
        TA_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        TB_new[i] =+Vdc/2*T1_new - Vdc/2*T2_new
        TC_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        
    #sector 5
    elif theta_internal < 5*pi_div_3:
        theta = theta_internal - 4*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2
        
        if Vref <= 0.866:
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:
            if T1_T2 > 1:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2

        TA[i] =-Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 + Vdc/2*T2

        TA_new[i] =-Vdc/2*T1_new + Vdc/2*T2_new
        TB_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        TC_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        
    #sector 6
    else:                               
        theta = theta_internal - 5*pi_div_3
        T1 = Vref*(np.cos(theta) - np.sin(theta)/sqrt3)
        T2 = Vref*(2/sqrt3)*np.sin(theta)
        T1_T2 = T1 + T2
        
        if Vref <= 0.866:
            T1 = T1
            T2 = T2
            T1_new = T1
            T2_new = T2
            
        elif Vref <= 1.0:
            if T1_T2 > 1:
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2
            T1_new = T1
            T2_new = T2
                
        else:
            if T1 > 1.0:
                T1 = 1.0
                T2 = 0
                T1_new = T1
                T2_new = T2
            elif T2 > 1.0:
                T1 = 0
                T2 = 1.0
                T1_new = T1
                T2_new = T2
            else:
                T1_temp = T1 / T1_T2
                T1_new = (T1_temp - offset) * gain
                T2_new = 1.0 - T1_new
                theta_temp = (theta - alpha)*(pi_div_6/(pi_div_6 - alpha))
                T1 = Vref*(np.cos(theta_temp) - np.sin(theta_temp)/sqrt3)
                T2 = Vref*(2/sqrt3)*np.sin(theta_temp)
                T1_T2 = T1 + T2
                T1 = T1 / T1_T2
                T2 = T2 / T1_T2

        TA[i] =+Vdc/2*T1 + Vdc/2*T2
        TB[i] =-Vdc/2*T1 - Vdc/2*T2
        TC[i] =+Vdc/2*T1 - Vdc/2*T2
        
        TA_new[i] =+Vdc/2*T1_new + Vdc/2*T2_new
        TB_new[i] =-Vdc/2*T1_new - Vdc/2*T2_new
        TC_new[i] =+Vdc/2*T1_new - Vdc/2*T2_new
        
#output
plt.plot(theta_input,TB,color='red',linewidth=1,linestyle='-')
plt.plot(theta_input,TA_new,color='blue',linewidth=1,linestyle='-')
#plt.plot(theta_input,TC,color='green',linewidth=1,linestyle='-')
plt.show()
