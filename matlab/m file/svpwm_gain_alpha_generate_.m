clear all

%linear
table_size = 100;
step_num = table_size*10;

Vs = linspace(sqrt(3)/2,sqrt(3),step_num);

OVMMode2Flag = linspace(0,0,step_num);
Vdc = 1;
temp2 = (1/2)*Vdc;
temp3 = sqrt(3);
temp4 = 1/sqrt(3);
num = size(Vs);

for i = 1:num(2)
    temp1(i) = (1/2)*Vs(i)*Vdc;
    if(Vs(i)<(sqrt(3)/2))  % linear
        f = @(theta) ( ... 
                temp1(i)*(cos(theta)+temp4*sin(theta)).*cos(theta).*(theta>=0 & theta<(pi/3)) ...%sector 1
                +temp1(i)*(cos(theta-pi/3)-temp3*sin(theta-pi/3)).*cos(theta).*(theta>=(pi/3) & theta<(2*pi/3)) ...%sector 2
                +temp1(i)*(-cos(theta-2*pi/3)-temp4*sin(theta-2*pi/3)).*cos(theta).*(theta>=(2*pi/3) & theta<(pi)) ...%sector 3
                +temp1(i)*(-cos(theta-pi)-temp4*sin(theta-pi)).*cos(theta).*(theta>=(pi) & theta<(4*pi/3)) ...%sector 4
                +temp1(i)*(-cos(theta-4*pi/3)+temp3*sin(theta-4*pi/3)).*cos(theta).*(theta>=(4*pi/3) & theta<(5*pi/3)) ...%sector 5
                +temp1(i)*(cos(theta-5*pi/3)+temp4*sin(theta-5*pi/3)).*cos(theta).*(theta>=(5*pi/3) & theta<=(2*pi)) ...%sector 6
                );
        F(i)=integral(f,0,pi*2)*2/(2*pi);
        OVMMode2Flag(i) = 0;
    elseif(Vs(i)<1)   %OVM1
        temp = Vs(i)*Vs(i) - 3/4;
        y = sqrt(3)/4 - (sqrt(3)/2)*sqrt(temp);
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
        OVMMode2Flag(i) = 0;
    else              %OVM2
        temp = (3/4)*Vs(i)*Vs(i)-(9/16);
        y = sqrt(temp) - sqrt(3)/4;
        x = 1 + y/sqrt(3);
        alpha(i) = atan(y/x);
        temp5 = pi*2/(pi-alpha(i)*6);
        
        f = @(theta) ( ... 
                temp2*cos(theta).*(theta>=0 & theta<alpha(i)) ...%sector 1-1
               +temp2*cos(theta).*(theta>=alpha(i) & theta<(pi/3 - alpha(i))) ...%sector 1-2
               +temp2*cos(theta).*(theta>=(pi/3 - alpha(i)) & theta<(pi/3)) ...%sector 1-3
               +temp2*cos(theta).*(theta>=(pi/3) & theta<(pi/3 + alpha(i))) ...%sector 2-1
               +((temp2)*((((cos(theta-pi/3) - temp4*sin(theta-pi/3))./(cos(theta-pi/3) + temp4*sin(theta-pi/3))) - 0.955*alpha(i)).*temp5 - 1)).*cos(theta).*(theta>=(pi/3 + alpha(i)) & theta<(2*pi/3 - alpha(i))) ...%sector 2-2
               +(-temp2)*cos(theta).*(theta>=(2*pi/3 - alpha(i)) & theta<(2*pi/3)) ...%sector 2-3
               +(-temp2)*cos(theta).*(theta>=(2*pi/3) & theta<(2*pi/3 + alpha(i))) ...%sector 3-1
               +(-temp2)*cos(theta).*(theta>=(2*pi/3 + alpha(i)) & theta<(pi - alpha(i))) ...%sector 3-2
               +(-temp2)*cos(theta).*(theta>=(pi - alpha(i)) & theta<(pi)) ...%sector 3-3
               +(-temp2)*cos(theta).*(theta>=(pi) & theta<(pi + alpha(i))) ...%sector 4-1
               +(-temp2)*cos(theta).*(theta>=(pi + alpha(i)) & theta<(4*pi/3 - alpha(i))) ...%sector 4-2
               +(-temp2)*cos(theta).*(theta>=(4*pi/3 - alpha(i)) & theta<(4*pi/3)) ...%sector 4-3
               +(-temp2)*cos(theta).*(theta>=(4*pi/3) & theta<(4*pi/3 + alpha(i))) ...%sector 5-1
               +((temp2)*(1-((((cos(theta-4*pi/3) - temp4*sin(theta-4*pi/3))./(cos(theta-4*pi/3) + temp4*sin(theta-4*pi/3))) - 0.955*alpha(i)).*temp5))).*cos(theta).*(theta>=(4*pi/3 + alpha(i)) & theta<(5*pi/3 - alpha(i))) ...%sector 5-2
               +(temp2)*cos(theta).*(theta>=(5*pi/3 - alpha(i)) & theta<(5*pi/3)) ...%sector 5-3
               +(temp2)*cos(theta).*(theta>=5*pi/3 & theta<(5*pi/3 + alpha(i))) ...%sector 6-1
               +(temp2)*cos(theta).*(theta>=(5*pi/3 + alpha(i)) & theta<(2*pi - alpha(i))) ...%sector 6-2
               +(temp2)*cos(theta).*(theta>=(2*pi - alpha(i)) & theta<=(2*pi))...%sector 6-3
            );
        F(i)=integral(f,0,pi*2)*2/(2*pi);
        OVMMode2Flag(i) = 1;
    end
    MI(i)=F(i)/(2/pi);
    Vref(i) = MI(i)/1.04596;
    Gain(i) = Vs(i)/Vref(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%re-generate
Vref_index = linspace(Vref(1),Vref(step_num),table_size);
gain_table_data = linspace(Vref(1),Vref(step_num),table_size);

for i = 1:table_size
    for j = 1:(step_num - 1)
        if (Vref_index(i) >=  Vref(j)) && (Vref_index(i) <  Vref(j+1))
            gain_table_data(i) = Gain(j);
            break;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output to a txt file

% creat a new file with the name of ovm_array_date_month_year_hour_minutes_second
% strname = datestr(now);
% strname = strrep(strname,':','_');
% strname = strrep(strname,'-','_');
% strname = strrep(strname,' ','_');
% strname = strcat('ovm_array_',strname);
% strpath = mfilename('fullpath');
% index_array = strfind(strpath,'\');
% last_point = size(index_array);
% index  = index_array(last_point(2));
% strpath = strpath(1:index)
% strpathaddname = strcat(strpath,strname,'.txt');
% txtfile = fopen(strpathaddname,'w');
% 
% % write the data to the txt file write the header
% fprintf(txtfile,'%s', 'int16_t aSqrtTable[');
% fprintf(txtfile,'%d', step_num);
% fprintf(txtfile,'%s\n', ']={\');
% %write the data as 16384=1.0
% line_num = 10;
% for i = 1:step_num
%     data = fix(Gain(i)*16384);
%     fprintf(txtfile,'%d',data);
%     fprintf(txtfile,'%s',',');
%     if(mod(i,line_num) == 0)
%         fprintf(txtfile,'%s\n', '\');
%     end
% end
% fprintf(txtfile,'%s\n', '\');
% fprintf(txtfile,'%s\n', '};');
% % close the file.
% code = fclose(txtfile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%OVM2
plot(Vref,Gain,'r')
grid on