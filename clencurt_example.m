%% This code shows the basics of Chebyshev differentiation and Clenshaw Curtis integration
clear all,close all
​
% parameters
Nz=60;
Lz=10;
​
% The differentiation matrix and integration nodes and weights.
[Dc,zc]=cheb(Nz);
[zic,wic]=clencurt(Nz);
% Note that the order is from -1 to 1
​
% since -1<zc<1 we need the factors for chain rule
z=Lz*(zc+1)/2;
dzcdz=2/Lz;
dzdzc=Lz/2;
D=(dzcdz)*Dc;
wi=wic*dzdzc;
​
% Now apply to a simple function
f=sin(pi*z/Lz);
% derivatives
fprimetrue=(pi/Lz)*cos(pi*z/Lz);
​
fprime=D*f;
​
%definite integral int_0^L f(y) dy
fdefint=wi*f
fdefinttrue=-(Lz/pi)*cos(pi)+(Lz/pi)*cos(0)
​
% definite integral over a range
fdefintrange=wi*(f.*(z<0.5*Lz).*(z>0.3*Lz))
​
%indefinite integral int_0^z f(y) dy
% this isn't used in practice all that often
finttrue=-(Lz/pi)*cos(pi*z/Lz)+Lz/pi;
fint=fliplr(cumsum(wi.*f')); % the fliplr accounts for the order of zc
​
figure(1)
clf
subplot(2,2,1)
plot(z,f)
grid on
xlabel('z')
ylabel('f')
subplot(2,2,2)
plot(z,fprime,'bo',z,fprimetrue,'r')
grid on
xlabel('z')
ylabel('df/dz')
​
subplot(2,2,4)
plot(z,fint,'bo',z,finttrue,'r')
grid on
xlabel('z')
ylabel('integral of f')
