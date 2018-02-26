clear all

theta=0:0.01:2*pi;
Vs = 1.1;
Vdc = 1;
y = sqrt((3/4)*Vs*Vs-(9/16)) - sqrt(3)/4;
x = 1 + y / sqrt(3);
alpha = atan(y/x);
%constant

temp1 = (1/2)*Vs*Vdc;
temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
temp5 = pi*2/(pi-alpha*6);

y1 = (temp2).*(theta>=0 & theta<(alpha)) ...%sector 1-1
    +(temp2).*(theta>=(alpha) & theta<(pi/3 - alpha)) ...%sector 1-2
    +(temp2).*(theta>=(pi/3 - alpha) & theta<(pi/3)) ...%sector 1-3
    +(temp2).*(theta>=(pi/3) & theta<(pi/3 + alpha)) ...%sector 2-1
    +((temp2)*((cos((theta-pi/3-alpha)*(pi/6)/(pi/6-alpha)) - temp3*sin((theta-pi/3-alpha)*(pi/6)/(pi/6-alpha)))./(cos((theta-pi/3-alpha)*(pi/6)/(pi/6-alpha)) + temp4*sin((theta-pi/3-alpha)*(pi/6)/(pi/6-alpha))))).*(theta>=(pi/3 + alpha) & theta<(2*pi/3 - alpha)) ...%sector 2-2
    +(-temp2).*(theta>=(2*pi/3 - alpha) & theta<(2*pi/3)) ...%sector 2-3
    +(-temp2).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha)) ...%sector 3-1
    +(-temp2).*(theta>=(2*pi/3 + alpha) & theta<(pi - alpha)) ...%sector 3-2
    +(-temp2).*(theta>=(pi - alpha) & theta<(pi)) ...%sector 3-3
    +(-temp2).*(theta>=(pi) & theta<(pi + alpha)) ...%sector 4-1
    +(-temp2).*(theta>=(pi + alpha) & theta<(4*pi/3 - alpha)) ...%sector 4-2
    +(-temp2).*(theta>=(4*pi/3 - alpha) & theta<(4*pi/3)) ...%sector 4-3
    +(-temp2).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha)) ...%sector 5-1
    +((temp2)*((-cos((theta-(pi*4/3)-alpha)*(pi/6)/(pi/6-alpha)) + temp3*sin((theta-(pi*4/3)-alpha)*(pi/6)/(pi/6-alpha)))./(cos((theta-(pi*4/3)-alpha)*(pi/6)/(pi/6-alpha)) + temp4*sin((theta-(pi*4/3)-alpha)*(pi/6)/(pi/6-alpha))))).*(theta>=(4*pi/3 + alpha) & theta<(5*pi/3 - alpha)) ...%sector 5-2
    +(temp2).*(theta>=(5*pi/3 - alpha) & theta<(5*pi/3)) ...%sector 5-3
    +(temp2).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha)) ...%sector 6-1
    +(temp2).*(theta>=(5*pi/3 + alpha) & theta<(2*pi - alpha)) ...%sector 6-2
    +(temp2).*(theta>=(2*pi - alpha) & theta<=(2*pi));%sector 6-3

y2 = (temp2).*(theta>=0 & theta<(alpha)) ...%sector 1-1
    +(temp2).*(theta>=(alpha) & theta<(pi/3 - alpha)) ...%sector 1-2
    +(temp2).*(theta>=(pi/3 - alpha) & theta<(pi/3)) ...%sector 1-3
    +(temp2).*(theta>=(pi/3) & theta<(pi/3 + alpha)) ...%sector 2-1
    +((temp2)*((((cos(theta-pi/3) - temp4*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3))) - 0.955*alpha).*temp5 - 1)).*(theta>=(pi/3 + alpha) & theta<(2*pi/3 - alpha)) ...%sector 2-2
    +(-temp2).*(theta>=(2*pi/3 - alpha) & theta<(2*pi/3)) ...%sector 2-3
    +(-temp2).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha)) ...%sector 3-1
    +(-temp2).*(theta>=(2*pi/3 + alpha) & theta<(pi - alpha)) ...%sector 3-2
    +(-temp2).*(theta>=(pi - alpha) & theta<(pi)) ...%sector 3-3
    +(-temp2).*(theta>=(pi) & theta<(pi + alpha)) ...%sector 4-1
    +(-temp2).*(theta>=(pi + alpha) & theta<(4*pi/3 - alpha)) ...%sector 4-2
    +(-temp2).*(theta>=(4*pi/3 - alpha) & theta<(4*pi/3)) ...%sector 4-3
    +(-temp2).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha)) ...%sector 5-1
    +((temp2)*(1-((((cos(theta-4*pi/3) - temp4*sin(theta-4*pi/3))./(cos(theta-4*pi/3) + temp4*sin(theta-4*pi/3))) - 0.955*alpha).*temp5))).*(theta>=(4*pi/3 + alpha) & theta<(5*pi/3 - alpha)) ...%sector 5-2
    +(temp2).*(theta>=(5*pi/3 - alpha) & theta<(5*pi/3)) ...%sector 5-3
    +(temp2).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha)) ...%sector 6-1
    +(temp2).*(theta>=(5*pi/3 + alpha) & theta<(2*pi - alpha)) ...%sector 6-2
    +(temp2).*(theta>=(2*pi - alpha) & theta<=(2*pi));%sector 6-3

%output waveform
plot(theta,y1,'r',theta,y2,'b')
leg1 = legend('English Paper','New method');
set(leg1,'box','on');
xlabel('wt')  
ylabel('Va')
title('phase voltage waveform')
grid on