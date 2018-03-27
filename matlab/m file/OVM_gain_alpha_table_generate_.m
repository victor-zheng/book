clear all

%linear
table_size = 192;
step_num = table_size*20;

Vs = linspace(sqrt(3)/2,sqrt(3),step_num);
linspace(0,0,table_size);
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
    Vref(i) = F(i)*pi/2;
    Gain(i) = Vs(i)/Vref(i);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%linear re-generate
Vref_index = linspace(Vref(1),Vref(step_num),table_size);
gain_table_data = linspace(0,0,table_size);
alpha_table_data = linspace(0,0,table_size);
OVM2flag_table_data = linspace(0,0,table_size);

for i = 1:table_size
    for j = 1:(step_num - 1)
        if (Vref_index(i) >=  Vref(j)) && (Vref_index(i) <=  Vref(j+1))
            gain_table_data(i) = Gain(j);
            alpha_table_data(i) = alpha(j);
            OVM2flag_table_data(i) = OVMMode2Flag(j);
            break;
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate the usefull data
float1_0 = 32768;

Vref_index_start_int = round(float1_0 * Vref_index(1));
Vref_index_end_int = round(float1_0 * Vref_index(table_size));
Vref_index_step_float = float1_0 * (Vref_index(2) - Vref_index(1));
Vref_index_step_int = round(Vref_index_step_float);

for i = 2:table_size
    if((OVM2flag_table_data(i) == 1) && (OVM2flag_table_data(i-1) == 0))
        Vref_index_OVM2_start = fix(float1_0 * Vref_index(i));
        Vref_index_OVM2_offset = i-1;
    end
end

alpha_table_size = fix(table_size - Vref_index_OVM2_offset);
hold_table_data = linspace(0,0,alpha_table_size);

for i = (Vref_index_OVM2_offset+1):table_size
    hold_table_data(i-Vref_index_OVM2_offset) = alpha_table_data(i);
end

Macros_1_div_sqrt3 = round(1*float1_0/sqrt(3));
Macros_1_div_pi = round(1*float1_0/pi);
Macros_pi_div_6 = round(pi*float1_0/6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output to a txt file

% creat a new file with the name of ovm_array_date_month_year_hour_minutes_second

strname = 'ovm_data_table';
strpath = mfilename('fullpath');
index_array = strfind(strpath,'\');
last_point = size(index_array);
index  = index_array(last_point(2));
strpath = strpath(1:index);
strpathaddname = strcat(strpath,strname,'.txt');
txtfile = fopen(strpathaddname,'w+');

% write the data to the txt file write the header
%write header of the file
  %get the generate time
strdate = datestr(now);
% strdate = strrep(strdate,':','_');
% strdate = strrep(strdate,'-','_');
% strdate = strrep(strdate,' ','_');

fprintf(txtfile,'%s\n','/**');
fprintf(txtfile,'%s\n','  ******************************************************************************');
fprintf(txtfile,'%s\n','  * @file    ovm_data_table');
fprintf(txtfile,'%s','  * @date    ');
fprintf(txtfile,'%s\n',strdate);
fprintf(txtfile,'%s\n','  ******************************************************************************');
fprintf(txtfile,'%s\n','*/');
fprintf(txtfile,'%s\n','');
%write the macros
fprintf(txtfile,'%s','#define    OVM_GAIN_ARRAY_SIZE       ((int16_t)');% macro 1
fprintf(txtfile,'%d',table_size);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_GAMMA_ARRAY_SIZE      ((int16_t)');% macro 2
fprintf(txtfile,'%d',alpha_table_size);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_GAMMA_ARRAY_OFFSET    ((int16_t)');% macro 3
fprintf(txtfile,'%d',Vref_index_OVM2_offset);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_VREF_MODE1_START  ((int16_t)');% macro 4
fprintf(txtfile,'%d',Vref_index_start_int);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_VREF_MODE2_START    ((int16_t)');% macro 1
fprintf(txtfile,'%d',Vref_index_OVM2_start);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_VREF_MODE2_END    ((int16_t)');% macro 1
fprintf(txtfile,'%d',Vref_index_end_int);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_VREF_INDEX_STEP   ((int16_t)');% macro 1
fprintf(txtfile,'%d',Vref_index_step_int);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_1_DIV_SQRT3   ((int16_t)');% macro 1
fprintf(txtfile,'%d',Macros_1_div_sqrt3);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_1_DIV_PI   ((int16_t)');% macro 1
fprintf(txtfile,'%d',Macros_1_div_pi);
fprintf(txtfile,'%s\n',')');

fprintf(txtfile,'%s','#define    OVM_PI_DIV_6   ((int16_t)');% macro 1
fprintf(txtfile,'%d',Macros_pi_div_6);
fprintf(txtfile,'%s\n',')');

%wrtie the Qformat for
fprintf(txtfile,'%s\n','');
fprintf(txtfile,'%s','/*the float number 1.0 equal to */');
fprintf(txtfile,'%d',float1_0);
fprintf(txtfile,'%s\n','*/');
fprintf(txtfile,'%s\n','');

%write table 1
fprintf(txtfile,'%s', 'uint16_t aOVMGain[');
fprintf(txtfile,'%s', 'OVM_GAIN_ARRAY_SIZE');
fprintf(txtfile,'%s\n', ']={\');

line_num = 10;  %The data number in one row
for i = 1:table_size
    data = round(gain_table_data(i)*float1_0);
    fprintf(txtfile,'%d',data);
    fprintf(txtfile,'%s',',');
    if(mod(i,line_num) == 0)
        fprintf(txtfile,'%s\n', '\');
    end
end
fprintf(txtfile,'%s\n', '\');
fprintf(txtfile,'%s\n', '};');
fprintf(txtfile,'%s\n','');
fprintf(txtfile,'%s\n','');

%write table 2
fprintf(txtfile,'%s', 'int16_t aOVMGamma[');
fprintf(txtfile,'%s', 'OVM_GAMMA_ARRAY_SIZE');
fprintf(txtfile,'%s\n', ']={\');

line_num = 10;  %The data number in one row
for i = 1:alpha_table_size
    data = round(hold_table_data(i)*float1_0);
    fprintf(txtfile,'%d',data);
    fprintf(txtfile,'%s',',');
    if(mod(i,line_num) == 0)
        fprintf(txtfile,'%s\n', '\');
    end
end
fprintf(txtfile,'%s\n', '};');
fprintf(txtfile,'%s\n','');
fprintf(txtfile,'%s\n','');

% close the file.
code = fclose(txtfile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%OVM2
plot(Vref,Gain,'r')
grid on