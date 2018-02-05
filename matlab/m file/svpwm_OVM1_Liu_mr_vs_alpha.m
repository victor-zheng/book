clear all
alpha = 0:0.01:0.5236;
temp1 = sqrt(3);
temp2 = pi/6;
tempangle = temp2-alpha;
item1 = alpha./cos(tempangle);
item2 = log(tan(temp2 + alpha./2));
MR1 = temp1*(item1 - item2);
plot(MR1,alpha,'r')
grid on