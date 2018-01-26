clear all
Vs = 1:0.01:1.732;
Vdc = 1;
temp = (3/4)*Vs.*Vs-(9/16);

temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs);
for i = 1:num(2)
y = sqrt(temp(i)) - sqrt(3)/4;
x = 1 + y/sqrt(3);
alpha(i) = atan(y/x);

f = @(theta) ( ... 
        temp2*cos(theta).*(theta>=0 & theta<alpha(i)) ...%sector 1-1
       +temp2*cos(theta).*(theta>=alpha(i) & theta<(pi/3 - alpha(i))) ...%sector 1-2
       +temp2*cos(theta).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
       +temp2*cos(theta).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
       +((temp2)*((cos(theta-pi/3) - temp3*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3)))).*cos(theta).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
       +(-temp2)*cos(theta).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
       +(-temp2)*cos(theta).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
       +(-temp2)*cos(theta).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
       +(-temp2)*cos(theta).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
       +(-temp2)*cos(theta).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
       +(-temp2)*cos(theta).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
       +(-temp2)*cos(theta).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
       +(-temp2)*cos(theta).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
       +((temp2)*((-cos(theta-4*pi/3) + temp3*sin(theta-4*pi/3))./(cos(theta-4*pi/3) + temp4*sin(theta-4*pi/3)))).*cos(theta).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
       +(temp2)*cos(theta).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
       +(temp2)*cos(theta).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
       +(temp2)*cos(theta).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
       +(temp2)*cos(theta).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi))...%sector 6-3
    );
F(i)=integral(f,0,pi*2)*2/(2*pi);
MI(i)=F(i)/(2/pi);
end
alpha2 = (6.40*MI - 6.09).*(MI>=0.9517 & MI<0.9800) ...
        +(11.75*MI - 11.34).*(MI>=0.9800 & MI<0.9975) ...
        +(48.96*MI - 48.43).*(MI>=0.9975);
plot(MI,alpha,'r',MI,alpha2,'b')
grid on