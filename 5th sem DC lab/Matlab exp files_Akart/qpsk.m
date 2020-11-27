clc;
clear all;
close all;
data=[0 1 1 1 1 0 0 0];

%QPSK Transmitter
%odd=1 even=0 --->315 degree
%odd=0 even=1 --->135 degree
%odd=1 even=1 --->45 degree
%odd=0 even=0 --->225 degree

odd=data(1:2:length(data));
even=data(2:2:length(data));
[ydata,t1]=nrzpolar(data);
[yodd,t2]=nrzpolar(odd);
[yeven,t3]=nrzpolar(even);
bitlength=floor(length(t2)/length(yodd));
I=yeven.*cos(2*pi*3*t3);
Q=yodd.*sin(2*pi*3*t3);
qpsk=I+Q;

r_sig=qpsk;   %channel

%QPSK coherent receiver

Id=qpsk.*cos(2*pi*3*t3);
Qd=qpsk.*sin(2*pi*3*t3);
x1=lowpass(Id,10000,2,4);
x2=lowpass(Qd,10000,2,4);
%Decision device
l=1;
for i=1:length(even)
    if (x1(find(t2==(l+bitlength/2-1)))>0)
        y1(i)=1;
    else
        y1(i)=0;
    end
    l=l+bitlength;
end
[demod_even,td]=nrzpolar(y1);
l=1;
for i=1:length(odd)
    if (x2(find(t3==(l+bitlength/2-1)))>0)
        y2(i)=1;
    else
        y2(i)=0;
    end
    l=l+bitlength;
end
[demod_odd,td]=nrzpolar(y2);
%demux
demod=[];
for i=1:length(odd)
    demod=[demod,y2(i),y1(i)];
end
[demod_data,tdemod]=nrzpolar(demod);

figure(1)
subplot(411)
plot(t1,ydata);
axis([0 8 -2 2])
title('Digital Serial Data(message signal)')
subplot(412)
plot(t2,yodd);
axis([0 4 -2 2])
title('Odd indexed data bits')
subplot(413)
plot(t3,yeven);
axis([0 4 -2 2])
title('Even indexed data bits')
subplot(414)
plot(t2,qpsk);
title('QPSK Modulation')
figure(2)
subplot(4,1,1)
plot(Id)
title('output of I-channel product');
subplot(4,1,2)
plot(Qd)
title('output of Q-channel product');
subplot(4,1,3)
plot(x1)
title('output of I-channel correlator');
subplot(4,1,4)
plot(x2)
title('output of Q-channel correlator');
figure(3)
subplot(3,1,1)
plot(td,demod_even)
axis([0 4 -2 2])
title('output of I-channel decision device');
subplot(3,1,2)
plot(td,demod_odd)
axis([0 4 -2 2])
title('output of Q-channel decision device');
subplot(3,1,3)
plot(tdemod,demod_data)
title('demodulated msg data');
axis([0 8 -2 2])