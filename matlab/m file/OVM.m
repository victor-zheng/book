clear all;
global hSector;
global wTimePhA;
global wTimePhB;
global wTimePhC;
global wX;
global wY;
global wZ;
t = 0:0.0002:0.2;
% dq to alpha-beta
speed = 30;  %Hz
Vq = 10000;   %+32767 to -32767
Vd = 0;
Vs = sqrt(Vq*Vq + Vd*Vd);
if Vs>32767
    Vq = Vq * 32767 / Vs;
    Vd = Vd * 32767 / Vs;
end
angle = t*speed*2*pi;
alpha = Vq * cos(angle) + Vd * sin(angle);
beta = -Vq * sin(angle) + Vd * cos(angle);

%alpha-beta to ABC
period = 2400;
hT_Sqrt3 = 2 * period * sqrt(3);
wUAlpha = alpha * hT_Sqrt3;
wUBeta = -beta * 2 * period;

wX = wUBeta;
wY = (wUBeta + wUAlpha)/2;
wZ = (wUBeta - wUAlpha)/2;

if wY < 0
    if wZ < 0
        hSector = 500+t;
        wTimePhA = ((wY - wZ)/262144);  
        wTimePhB = wTimePhA + wZ/131072;
        wTimePhC = wTimePhA - wY/131072;   
    else %/* wZ >= 0 */
        if wX <= 0
            hSector = 400+t;;
            wTimePhA = ((wX - wZ)/262144);       
            wTimePhB = wTimePhA + wZ/131072;
            wTimePhC = wTimePhB - wX/131072;
        else %/* wX > 0 */
            hSector = 300+t;;
            wTimePhA = ((wY - wX)/262144);  
            wTimePhC = wTimePhA - wY/131072;
            wTimePhB = wTimePhC + wX/131072;
        end
    end
else %/* wY > 0 */
    if wZ >= 0
        hSector = 200+t;;
        wTimePhA = ((wY - wZ)/262144);            
        wTimePhB = wTimePhA + wZ/131072;
        wTimePhC = wTimePhA - wY/131072;
    else %/* wZ < 0 */
      if wX <= 0
          hSector = 600+t;;
          wTimePhA = ((wY - wX)/262144);  
          wTimePhC = wTimePhA - wY/131072;
          wTimePhB = wTimePhC + wX/131072;
      else %/* wX > 0 */
          hSector = 100+t;;
          wTimePhA = ((wX - wZ)/262144);       
          wTimePhB = wTimePhA + wZ/131072;
          wTimePhC = wTimePhB - wX/131072;
      end
    end
end
plot(t,hSector,'r')
%plot(t,alpha,'r',t,beta,'g')
%plot(t,wX,'r',t,wY,'g',t,wZ,'b')
%plot(t,wTimePhA,'r',t,wTimePhB,'g',t,wTimePhC,'b')
grid