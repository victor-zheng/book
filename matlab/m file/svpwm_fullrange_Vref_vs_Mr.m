clear all

%linear
Vs1 = 0:0.001:sqrt(3)/2;
Vdc = 1;

temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs1);

for i = 1:num(2)
    temp1 = (1/2)*Vs1(i)*Vdc;
    f = @(theta) ( ... 
                temp1*(cos(theta)+temp4*sin(theta)).*cos(theta).*(theta>=0 & theta<(pi/3)) ...%sector 1
                +temp1*(cos(theta-pi/3)-temp3*sin(theta-pi/3)).*cos(theta).*(theta>=(pi/3) & theta<(2*pi/3)) ...%sector 2
                +temp1*(-cos(theta-2*pi/3)-temp4*sin(theta-2*pi/3)).*cos(theta).*(theta>=(2*pi/3) & theta<(pi)) ...%sector 3
                +temp1*(-cos(theta-pi)-temp4*sin(theta-pi)).*cos(theta).*(theta>=(pi) & theta<(4*pi/3)) ...%sector 4
                +temp1*(-cos(theta-4*pi/3)+temp3*sin(theta-4*pi/3)).*cos(theta).*(theta>=(4*pi/3) & theta<(5*pi/3)) ...%sector 5
                +temp1*(cos(theta-5*pi/3)+temp4*sin(theta-5*pi/3)).*cos(theta).*(theta>=(5*pi/3) & theta<=(2*pi)) ...%sector 6
                );
F(i)=integral(f,0,pi*2)*2/(2*pi);
MI(i)=F(i)/(2/pi);
end

%OVM1
Vs2 = sqrt(3)/2:0.001:1;
temp = Vs2.*Vs2 - 3/4;
temp1 = (1/2)*Vs2*Vdc;
temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs2);

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
MI2(i)=F(i)/(2/pi);
end

%OVM2
Vs3 = 1:0.001:1.732;

Vdc = 1;
temp = (3/4)*Vs3.*Vs3-(9/16);

num = size(Vs3);
for i = 1:num(2)
y = sqrt(temp(i)) - sqrt(3)/4;
x = 1 + y/sqrt(3);
alpha(i) = atan(y/x);

f = @(theta) ( ... 
        temp2*cos(theta).*(theta>=0 & theta<alpha(i)) ...%sector 1-1
       +temp2*cos(theta).*(theta>=alpha(i) & theta<(pi/3 - alpha(i))) ...%sector 1-2
       +temp2*cos(theta).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
       +temp2*cos(theta).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
       +((temp2)*((cos((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) - temp3*sin((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))))./(cos((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp4*sin((theta-pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i)))))).*cos(theta).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
       +(-temp2)*cos(theta).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
       +(-temp2)*cos(theta).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
       +(-temp2)*cos(theta).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
       +(-temp2)*cos(theta).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
       +(-temp2)*cos(theta).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
       +(-temp2)*cos(theta).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
       +(-temp2)*cos(theta).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
       +(-temp2)*cos(theta).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
       +((temp2)*((-cos((theta-4*pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp3*sin((theta-4*pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))))./(cos((theta-4*pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i))) + temp4*sin((theta-4*pi/3-alpha(i))*(pi/6)/(pi/6-alpha(i)))))).*cos(theta).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
       +(temp2)*cos(theta).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
       +(temp2)*cos(theta).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
       +(temp2)*cos(theta).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
       +(temp2)*cos(theta).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi))...%sector 6-3
    );
F(i)=integral(f,0,pi*2)*2/(2*pi);
MI3(i)=F(i)/(2/pi);
end
plot(Vs1,MI,'r',Vs2,MI2,'b',Vs3,MI3,'g')
grid on