clear all

theta=0:0.01:2*pi;
temp1 = sqrt(3)/2;
temp2 = 1/2;
temp3 = 3/2;

y=((temp1)*cos(theta)+(temp2)*sin(theta)).*(theta>=0 & theta<(pi/3)) ...
    +((temp1)*cos(theta-pi/3)+(-temp3)*sin(theta-pi/3)).*(theta>=(pi/3) & theta<(2*pi/3)) ...
    +((-temp1)*cos(theta-2*pi/3)+(-temp2)*sin(theta-2*pi/3)).*(theta>=(2*pi/3) & theta<(pi)) ...
    +((-temp1)*cos(theta-pi)+(-temp2)*sin(theta-pi)).*(theta>=(pi) & theta<(4*pi/3)) ...
    +((-temp1)*cos(theta-4*pi/3)+(temp3)*sin(theta-4*pi/3)).*(theta>=(4*pi/3) & theta<(5*pi/3)) ...
    +((temp1)*cos(theta-5*pi/3)+(temp2)*sin(theta-5*pi/3)).*(theta>=(5*pi/3) & theta<=(2*pi));

plot(theta,y,'r')

grid on