clc;
close all;
clear all;
fm=3400;
T=1/fm;
del=0.4;

%Sampling Operation
fs=20*fm;
Ts=1/fs;
n=0:Ts:2*T;              
yn=sin(2*pi*fm*n);   
subplot(3,1,1);
plot(n,yn);
hold on;
title('Sampled Signal');
ylabel('Amplitude--->');
xlabel('Time--->');

digout=[0];
xstaircase=[0];

for i=1:length(yn)-1
    if(xstaircase(i)<=yn(i))
        xstaircase(i+1)=xstaircase(i)+del;
        d=1;
    else
        xstaircase(i+1)=xstaircase(i)-del;
        d=0;
    end
    digout=[digout, d];
end
stairs(n,xstaircase,'r');

xlabel('time')
ylabel('amplitude')
title('DM waveforms')
legend('analog signal','staircase signal')
hold off

subplot(3,1,2)
stairs(n,digout,'g')
xlabel('time')
ylabel('amplitude')
title('Digital output signal')


%DM demodulation
rsignal=digout;

temp=[0];
for i=1:length(rsignal)-1
    if(rsignal(i)==1)
        decsig(i)=del;
    else
        decsig(i)=-del;
    end
    temp(i+1)=decsig(i)+temp(i);
end

subplot(3,1,3)
plot(n,temp)
xlabel('time')
ylabel('amplitude')
title('Demodulated signal')