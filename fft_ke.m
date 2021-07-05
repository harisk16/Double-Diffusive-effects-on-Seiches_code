load ke_lineplot_data

%myouts=linspace(0,290,2001);
%ketotid=interp1(0:290,ketoti,myouts,'spline');
%ketotddd=interp1(0:290,ketotvdd,myouts,'spline');
%ketotnoddd=interp1(0:290,ketotvnodd,myouts,'spline');

iis = iis(1:290);
L = 290;
T = 290;
Fs= 1;
fft_ketoti = fft(ketoti(1:290));
P2 = abs(fft_ketoti/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1) 
title('Frequency spectrum of KE')
xlabel('f (Hz)')
ylabel('|P1(f)|')

