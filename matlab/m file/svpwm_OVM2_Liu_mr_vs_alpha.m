clear all
alpha = 0:0.01:0.5236;
temp1 = sqrt(3);
temp2 = pi/6;

item1 = sin(alpha);
item2 = (temp1/2)*log(tan(temp2 + alpha./2));
MR1 = 2*(item1 - item2);
alpha2 = (6.40*MR1 - 6.09).*(MR1>=0.9517 & MR1<0.9800) ...
        +(11.75*MR1 - 11.34).*(MR1>=0.9800 & MR1<0.9975) ...
        +(48.96*MR1 - 48.43).*(MR1>=0.9975);
plot(MR1,alpha,'r',MR1,alpha2,'b')
grid on