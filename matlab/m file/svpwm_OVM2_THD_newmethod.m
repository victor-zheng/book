clear all

Vs = 1:0.01:1.732;
num = size(Vs);
Vdc = 1;
%constant
temp = (3/4)*Vs.*Vs-(9/16);
temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
for i = 1:num(2)
    y = sqrt(temp(i)) - sqrt(3)/4;
    x = 1 + y/sqrt(3);
    alpha(i) = atan(y/x);
    temp5 = pi*2/(pi-alpha(i)*6);
    theta=0:0.01:2*pi;
    y1 = (temp2).*(theta>=0 & theta<(alpha(i))) ...%sector 1-1
        +(temp2).*(theta>=(alpha(i)) & theta<(pi/3 - alpha(i))) ...%sector 1-2
        +(temp2).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
        +(temp2).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
        +((temp2)*((cos((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) - temp3*sin((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))))./(cos((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp4*sin((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i)))))).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
        +(-temp2).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
        +(-temp2).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
        +(-temp2).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
        +(-temp2).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
        +(-temp2).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
        +(-temp2).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
        +(-temp2).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
        +(-temp2).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
        +((temp2)*((-cos((theta-(pi*4/3)-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp3*sin((theta-(pi*4/3)-alpha(i))*(pi/6)/(pi/6-alpha(i))))./(cos((theta-(pi*4/3)-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp4*sin((theta-(pi*4/3)-alpha(i))*(pi/6)/(pi/6-alpha(i)))))).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
        +(temp2).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
        +(temp2).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
        +(temp2).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
        +(temp2).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi));%sector 6-3
    
     y2 = (temp2).*(theta>=0 & theta<(alpha(i))) ...%sector 1-1
        +(temp2).*(theta>=(alpha(i)) & theta<(pi/3 - alpha(i))) ...%sector 1-2
        +(temp2).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
        +(temp2).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
        +((temp2)*((cos(theta-pi/3) - temp3*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3)))).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
        +(-temp2).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
        +(-temp2).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
        +(-temp2).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
        +(-temp2).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
        +(-temp2).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
        +(-temp2).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
        +(-temp2).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
        +(-temp2).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
        +((temp2)*((-cos(theta-pi*4/3) + temp3*sin(theta-pi*4/3))./(cos(theta-pi*4/3) + temp4*sin(theta-pi*4/3)))).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
        +(temp2).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
        +(temp2).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
        +(temp2).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
        +(temp2).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi));%sector 6-3
    
     y3=temp2.*(theta>=0 & theta<alpha(i)) ...%sector 1-1
       +temp2.*(theta>=alpha(i) & theta<(pi/3 - alpha(i))) ...%sector 1-2
       +temp2.*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
       +temp2.*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
       +((temp2)*((((cos(theta-pi/3) - temp4*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3))) - 0.955*alpha(i)).*temp5 - 1)).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
       +(-temp2).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
       +(-temp2).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
       +(-temp2).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
       +(-temp2).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
       +(-temp2).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
       +(-temp2).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
       +(-temp2).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
       +(-temp2).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
       +((temp2)*(1-((((cos(theta-4*pi/3) - temp4*sin(theta-4*pi/3))./(cos(theta-4*pi/3) + temp4*sin(theta-4*pi/3))) - 0.955*alpha(i)).*temp5))).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
       +(temp2).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
       +(temp2).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
       +(temp2).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
       +(temp2).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi));
   
        h1 = thd(y1);
        h2 = thd(y2);
        h3 = thd(y3);
        point1(i) = power(10,h1/10);
        point2(i) = power(10,h2/10);
        point3(i) = power(10,h3/10);
end
plot(Vs,point1,'r',Vs,point3,'b',Vs,point2,'g')
title('THD compare');
leg1 = legend('English Paper','New Method','Chinese Paper');
set(leg1,'box','on');
grid on
xlabel('Amplitude of Vref')  
ylabel('THD') 