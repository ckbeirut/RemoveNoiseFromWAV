clc;clear all;close all;

[x,Fs]=audioread('InputAudio.wav');
audioinfo('InputAudio.wav');          %In case Nbits is needed
info= audioinfo('InputAudio.wav');
Nbits=info.BitsPerSample;
%sound(x,Fs);
L=length(x);
N = 2^nextpow2(L);

%Plot the spectrum
df = Fs / N;
w = (-(N/2):(N/2)-1)*df;   %frequency as the x axis

y = fft(x,N);
y2 = fftshift(y);
figure;
plot(w,20*log10(abs(y2)))
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title ('Magnitude spectrum of the signal in decibel');
grid on;
grid minor;

%waitforbuttonpress;
%The first pic is approximately 1000 so
F1=950;     
F2=1050;
%The first pic is close to 3000 so
F3=2950;
F4=3050;

w1=(F1*2)/Fs;
w2=(F2*2)/Fs;
w3=(F3*2)/Fs;
w4=(F4*2)/Fs;

l=[w1 w2];
h=[w3 w4];

figure;
b = fir1(2000,[l h],'DC-1');
freqz(b,1);
fvtool(b,1);
grid on;
grid minor;
title ('Frequency response of the filter');
fOut = conv (x,b);
figure;
plot (w,20*log10(abs(fftshift(fft(fOut,N)))));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title ('Magnitude spectrum of the signal after filtering in decibel');
grid on;
grid minor;
sound(fOut, Fs);
audiowrite('OutPut.wav',fOut,Fs);


