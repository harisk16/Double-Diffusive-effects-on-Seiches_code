%% This file determines the effect of double diffusion on the flow
clear all;

cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% Determine the max and minimum value of density at t =0s
ii = 0;
s0v=spins_reader_new('s',ii);
t0v=spins_reader_new('t',ii);
rho0v = eqn_of_state(t0v,s0v);
mxrho = max(rho0v(:));
mnrho = min(rho0v(:));

% Set value of time at which analysis is to be done
ii = 50;
fi =1;
sv = spins_reader_new('s',ii);
tv = spins_reader_new('t',ii);
rhov_ii = eqn_of_state(tv,sv);
ddiffv = (rhov_ii > mxrho) - (rhov_ii < mnrho); 
figure(fi);
fig = figure(fi);
clf
colormap darkjet;
subplot(2,2,1);
pcolor(x1dv,z1dv,ddiffv'),shading flat;
ylabel('z (m)')
title('Effect of double diffusion-top(no slip), bot(free slip)')

cd ../heatsalt32drealshortinv
spinsgrid2d
si = spins_reader_new('s',ii);
ti = spins_reader_new('t',ii);
rhoi_ii = eqn_of_state(ti,si);
ddiffi = (rhoi_ii > mxrho) - (rhoi_ii < mnrho);
colormap darkjet;
subplot(2,2,1);
pcolor(x1dv,z1dv,ddiffi'),shading flat;
ylabel('z (m)')
xlabel('x (m)')

print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/DD_effect/time_%d.jpg',ii))

cd ../harishankar_matlab

