clear all, close all
% longwave equation solver used to build a velocity and density field
  format long, format compact
  % number of points
  N=300;
  % the derivative matrix
  [D,zc]=cheb(N); D2=D^2; D2=D2(2:N,2:N); 
  % the integration points
  [zi weight]=clencurt(N);
  % physical domain size and info for the chain rule
  H=1;
  dzpdzc=H*0.5;
  dzcdzp=1/dzpdzc;
  % physical parameters
  z0=0.7*H
  d=0.025*H;
  bigl=H/2;
  zphys=0.5*H*(zc+1);
  z0=0.49*H;
  cntr=0
  for z0=0.24:0.001:0.26
      cntr=cntr+1
  % the density and N^2 profiles
%   myn2=@(zz,z0,d) 0.02*9.81*sech((zz-z0)/d).*sech((zz-z0)/d)/d;
%   myrho=@(zz,z0,d) 1-0.02*tanh((zz-z0)/d);
  % two pycnoclines
  a=0.01; d=0.025;
  a2=0.01;z02=1-z0+0.005;d2=0.025;
  myn2=@(zz,z0,d) a*9.81*sech((zz-z0)/d).*sech((zz-z0)/d)/d+a2*9.81*sech((zz-z02)/d2).*sech((zz-z02)/d2)/d2;
  myrho=@(zz,z0,d) 1-a*tanh((zz-z0)/d)-a2*tanh((zz-z02)/d2);
  n2physical=myn2(zphys,z0,d);
  n2max=max(n2physical);
  
  
  % make up the matrices for the e-val prog.

%define B
B=-D2*(1/dzpdzc)^2;
%define A
A=diag(n2physical(2:end-1));
% Solve the e-val prob 
[ev ee]=eig(A,B);
% sort the eigenvalues
[cs csi]=sort(sqrt(diag(ee)),'descend');
c1=cs(1);c2=cs(2);
% select the eigenfunctions and normalize
phi1=ev(:,csi(1));mxphi=max(phi1); mxabsphi=max(abs(phi1(:)));
if mxphi>0
 phi1=phi1/mxphi;
else
 phi1=-phi1/mxabsphi;
end
phi2=ev(:,csi(2));phi2=phi2/max(phi2);
% get the WNL coefficients
phi1p=D*[0;phi1;0]*dzcdzp;
S1=sum(weight'.*(phi1p.^2)*dzpdzc);
r10_1=-0.75*sum(weight'.*(phi1p.^3)*dzpdzc)/S1
r01_1=-0.5*c1*sum(weight'.*([0;phi1;0].^2)*dzpdzc)/S1
b01=sign(r10_1)*0.1*H;
c1wnlfact=(1+2*r10_1*b01/3)
lambda1wnl=sqrt(-6*r01_1/(b01*c1*r10_1))

phi2p=D*[0;phi2;0]*dzcdzp;
S2=sum(weight'.*(phi2p.^2)*dzpdzc);
r10_2=-0.75*sum(weight'.*(phi2p.^3)*dzpdzc)/S2
r01_2=-0.5*c2*sum(weight'.*([0;phi2;0].^2)*dzpdzc)/S2
b02=sign(r10_2)*0.1*H;
c2wnlfact=(1+2*r10_2*b02/3)
lambda2wnl=sqrt(-6*r01_2/(b02*c2*r10_2))

 r10s(cntr)=r10_1;
 r10s2(cntr)=r10_2;
  
% figure(1)
% clf
% subplot(1,2,1)
% plot(n2physical,zphys,'b-')
% xlabel('N^2')
% ylabel('z')
% grid on
% subplot(1,2,2)
% plot(phi1,zphys(2:end-1),'b-',phi2,zphys(2:end-1),'r-')
% grid on
% xlabel('phi')
% ylabel('z')

phi1mat=repmat([0;phi1;0],1,500);
phi2mat=repmat([0;phi2;0],1,500);
phi1pmat=repmat(phi1p,1,500);
phi2pmat=repmat(phi2p,1,500);
L=10*H;
xphys=linspace(-L,L,500);
[x z]=meshgrid(xphys,zphys);
eta=b02*(sech((x-0.5*L)/lambda2wnl).^2).*phi2mat-b02.*(sech((x+0.5*L)/lambda2wnl).^2).*phi2mat;
rho=myrho(z-eta,z0,d);
w=-b02*(tanh((x-0.5*L)/lambda2wnl)/lambda2wnl).*(sech((x-0.5*L)/lambda2wnl).^2).*phi2mat;
w=w+b02.*(tanh((x+0.5*L)/lambda2wnl)/lambda2wnl).*(sech((x+0.5*L)/lambda2wnl).^2).*phi2mat;
u=b02*c2*(sech((x-0.5*L)/lambda2wnl).^2).*phi2pmat-b02*c2*(sech((x+0.5*L)/lambda2wnl).^2).*phi2pmat;
figure
clf
subplot(2,2,1)
pcolor(x,z,eta),shading flat,colormap darkjet,colorbar
subplot(2,2,2)
pcolor(x,z,rho),shading flat,colormap darkjet,colorbar
title(z0)
subplot(2,2,3)
pcolor(x,z,u),shading flat,colormap darkjet,colorbar
subplot(2,2,4)
pcolor(x,z,w),shading flat,colormap darkjet,colorbar
  end
figure(111)
clf
subplot(1,2,1)
plot(n2physical,zphys,'b-')
xlabel('N^2')
ylabel('z')
grid on
subplot(1,2,2)
plot(phi1,zphys(2:end-1),'b-',phi2,zphys(2:end-1),'r-')
grid on
xlabel('phi')
ylabel('z')