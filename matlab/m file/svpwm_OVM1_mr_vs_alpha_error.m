clear all
Vs = sqrt(3)/2:0.001:1;

alpha3 = 0:0.01:0.5236;
alpha3_temp1 = sqrt(3);
alpha3_temp2 = pi/6;
alpha3_tempangle = alpha3_temp2-alpha3;
alpha3_item1 = alpha3./cos(alpha3_tempangle);
alpha3_item2 = log(tan(alpha3_temp2 + alpha3./2));
MR1 = alpha3_temp1*(alpha3_item1 - alpha3_item2);


Vdc = 1;
temp = Vs.*Vs - 3/4;
temp1 = (1/2)*Vs*Vdc;
temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs);

for i = 1:num(2)
y = sqrt(3)/4 - (sqrt(3)/2)*sqrt(temp(i));
x = 1 - y/sqrt(3);
alpha(i) = atan(y/x);
f = @(theta) ( ... 
                ((temp1(i))*cos(theta)+(temp1(i)*temp4)*sin(theta)).*cos(theta).*(theta>=0 & theta<(alpha(i))) ...
                +(temp2).*cos(theta).*(theta>=(alpha(i)) & theta<(pi/3 - alpha(i))) ...
                +((temp1(i))*cos(theta)+(temp1(i)*temp4)*sin(theta)).*cos(theta).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1
                +((temp1(i))*cos(theta-pi/3)+(-temp1(i)*temp3)*sin(theta-pi/3)).*cos(theta).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...
                +((temp2)*((cos(theta-pi/3) - temp3*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3)))).*cos(theta).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...
                +((temp1(i))*cos(theta-pi/3)+(-temp1(i)*temp3)*sin(theta-pi/3)).*cos(theta).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2
                +((-temp1(i))*cos(theta-2*pi/3)+(-temp1(i)*temp4)*sin(theta-2*pi/3)).*cos(theta).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...
                +(-temp2).*cos(theta).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...
                +((-temp1(i))*cos(theta-2*pi/3)+(-temp1(i)*temp4)*sin(theta-2*pi/3)).*cos(theta).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector3
                +((-temp1(i))*cos(theta-pi)+(-temp1(i)*temp4)*sin(theta-pi)).*cos(theta).*(theta>=(pi) & theta<(pi + alpha(i))) ...
                +(-temp2).*cos(theta).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...
                +((-temp1(i))*cos(theta-pi)+(-temp1(i)*temp4)*sin(theta-pi)).*cos(theta).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector4
                +((-temp1(i))*cos(theta-4*pi/3)+(temp1(i)*temp3)*sin(theta-4*pi/3)).*cos(theta).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...
                +((temp2)*((-cos(theta-4*pi/3) + temp3*sin(theta-4*pi/3))./(cos(theta-4*pi/3) + temp4*sin(theta-4*pi/3)))).*cos(theta).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...
                +((-temp1(i))*cos(theta-4*pi/3)+(temp1(i)*temp3)*sin(theta-4*pi/3)).*cos(theta).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5
                +((temp1(i))*cos(theta-5*pi/3)+(temp1(i)*temp4)*sin(theta-5*pi/3)).*cos(theta).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...
                +(temp2).*cos(theta).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...
                +((temp1(i))*cos(theta-5*pi/3)+(temp1(i)*temp4)*sin(theta-5*pi/3)).*cos(theta).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi)) ...%sector 6
    );
F(i)=integral(f,0,pi*2)*2/(2*pi);
MI(i)=F(i)/(2/pi);
end
alpha2 = (-30.23*MI + 27.94).*(MI>=0.9068 & MI<0.9095) ...
    +(-8.58*MI + 8.23).*(MI>=0.9095 & MI<0.9485) ...
    +(-26.43*MI + 25.15).*(MI>=0.9485 & MI<0.9517);
plot(MI,alpha,'r',MI,alpha2,'b',MR1,alpha3,'g')
grid on