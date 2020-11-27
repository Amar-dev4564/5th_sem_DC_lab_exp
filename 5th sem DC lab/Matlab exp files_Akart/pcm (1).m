clc;
close all;
clear all;
fm=3400;
T=1/fm;
N=input('Enter N value for N-bit PCM system');
L=2^N;
% Signal Generation
t=0:0.00001:2*T;
y=8*sin(2*pi*fm*t);                             % Amplitude Of signal is 8v
subplot(3,1,1);
plot(t,y)
title('Analog Signal');
ylabel('Amplitude--->');
xlabel('Time--->');

%Sampling Operation
fs=8*fm;
Ts=1/fs;
n=0:Ts:2*T;              
yn=8*sin(2*pi*fm*n);   
subplot(3,1,2);
stem(n,yn);
title('Sampled Signal');
ylabel('Amplitude--->');
xlabel('Time--->');

% Quantization Process
 vmax=8;
 vmin=-vmax;
 del=(vmax-vmin)/L;
 part=vmin:del:vmax;                                  % level are between vmin and vmax with difference of del
 values=vmin-(del/2):del:vmax+(del/2);               % Contain Quantized valuses 
[level,q]=quantiz(yn,part,values);                     % Quantization process
                                                                      % ind contain index number and q contain quantized  values
 
 subplot(3,1,3);
 stem(n,q)                                       % Display the Quantize values
 title('Quantized Signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');
  
%  Encoding Process
figure
code=de2bi(level,'left-msb');             % Convert decimal to binary
 k=1;
for i=1:length(q)
    for j=1:N
        coded(k)=code(i,j);                  % convert code matrix to a coded row vector
        k=k+1;
    end
end

[d,t]=nrzunipolar(coded);
subplot(2,1,1);
plot(t,d);
axis([0 N*length(q) -2 2]) 
title('PCM output:Encoded Digital Signal');
ylabel('Amplitude--->');
xlabel('Time--->');
 
 %PCM decoder
 
 qunt=reshape(coded,N,length(coded)/N);
 decoded=bi2de(qunt','left-msb');                    % Getback the index in decimal form
 subplot(2,1,2); 
 plot(n,decoded);                                                        % Plot Demodulated signal
 title('Decoded analog signal');
 ylabel('Amplitude--->');
 xlabel('Time--->');