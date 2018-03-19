clear all
Vs = 0:0.001:sqrt(3)/2;
Vdc = 1;


temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs);

for i = 1:num(2)
    temp1 = (1/2)*Vs(i)*Vdc;
    f = @(theta) ( ... 
                temp1*(cos(theta)+temp4*sin(theta)).*cos(theta).*(theta>=0 & theta<(pi/3)) ...%sector 1
                +temp1*(cos(theta-pi/3)-temp3*sin(theta-pi/3)).*cos(theta).*(theta>=(pi/3) & theta<(2*pi/3)) ...%sector 2
                +temp1*(-cos(theta-2*pi/3)-temp4*sin(theta-2*pi/3)).*cos(theta).*(theta>=(2*pi/3) & theta<(pi)) ...%sector 3
                +temp1*(-cos(theta-pi)-temp4*sin(theta-pi)).*cos(theta).*(theta>=(pi) & theta<(4*pi/3)) ...%sector 4
                +temp1*(-cos(theta-4*pi/3)+temp3*sin(theta-4*pi/3)).*cos(theta).*(theta>=(4*pi/3) & theta<(5*pi/3)) ...%sector 5
                +temp1*(cos(theta-5*pi/3)+temp4*sin(theta-5*pi/3)).*cos(theta).*(theta>=(5*pi/3) & theta<=(2*pi)) ...%sector 6
                );
F1(i)=integral(f,0,pi*2)*2/(2*pi);
F2(i)=Vs(i)*(2/3);
end
%plot(Vs,MI,'r')
%grid on