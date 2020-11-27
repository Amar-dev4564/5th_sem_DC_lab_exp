clc;
clear all;
close all;
%input binary serial msg data
data=[1 0 1 1 1 0 1 0];
[d,t]=nrzpolar(data);
bitlength=floor(length(t)/length(data));
%differential encoding
ref=0;
d_data(1)=~xor(ref,data(1));
for i=2:length(data)
    d_data(i)=~xor(data(i),d_data(i-1));
end
[d_d,t]=nrzpolar(d_data);
%carrier generation
c=5*sin(2*pi*5*t);
%product modulator
dpsk=d_d.*c;


y=dpsk;   %channel

%noncoherent detection 

y1=[zeros(1,bitlength),y(1:length(y)-bitlength)];


y2=y.*y1;
y3=lowpass(y2,10000,5,4);
for i=1:length(y3)
    if (y3(i)>=0)
        y4(i)=1;
    else
        y4(i)=0;
    end
end


%plotting waveforms
figure(1);
subplot(311)
plot(t,d);
title('Message signal')
axis([0 length(data) -2 2])
subplot(312)
plot(t,d_d);
title('Differentialy encoded msg signal')
axis([0 length(data) -2 2])
subplot(313)
plot(t,dpsk);
title('DPSK signal')

figure(2)
subplot(311)
plot(t,y2)
title('receiver product modulator o/p')
subplot(312)
plot(t,y3);
title('lowpass filtered o/p')
subplot(313)
plot(t,y4);
title('regenerated low pass filtered o/p')
axis([0 length(data) -2 2])