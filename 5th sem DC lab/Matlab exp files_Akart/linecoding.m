clc;
clear all;
close all;
data=[0 1 1 0 1 0 0 0 1 1];
[y1,t]=nrzunipolar(data);
[y2,t]=nrzpolar(data);
[y3,t]=nrzbipolar(data);
[y4,t]=rzunipolar(data);
[y5,t]=rzpolar(data);
[y6,t]=rzbipolar(data);
[y7,t]=manchester(data);
figure(1);
subplot(711)
plot(t,y1);
title('NRZ unipolar format')
axis([0 10 -2 2])
subplot(712)
plot(t,y2);
title('NRZ polar format')
axis([0 10 -2 2])
subplot(713)
plot(t,y3);
title('NRZ bipolar format')
axis([0 10 -2 2])
subplot(714)
plot(t,y4);
title('RZ unipolar format')
axis([0 10 -2 2])
subplot(715)
plot(t,y5);
title('RZ polar format')
axis([0 10 -2 2])
subplot(716)
plot(t,y6);
title('RZ bipolar format')
axis([0 10 -2 2])
subplot(717)
plot(t,y7);
title('Manchester format')
axis([0 10 -2 2])