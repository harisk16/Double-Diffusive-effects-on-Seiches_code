% This will calculate the verical integral of dissipation
clear all; 
cd ../heatsalt32drealshortnodd
spinsgrid2d
z1di=z1d;z1di=z1d;x1dv = x1d;

% Find dimensions
Nx = NX;
Nz = NZ;
Lz = max(z1d(:));

% Define parameters for integration

[zic,wic]=clencurt(NZ-1);

% since -1<zc<1 we need the factors for chain rule
z=Lz*(zic+1)/2;
dzcdz=2/Lz;
dzdzc=Lz/2;
wi=wic*dzdzc;

% Loop over all time and read dissipation value

for ii=1:290
	spinsread2dnewts
    % Loop over x and integrate dissipation over z
		for x_pt = 1:Nx 
			keatx = ke(x_pt,:);
            transpose = keatx';
			keint(x_pt,ii) = (wi*transpose)/Lz;
		end
    
end
ts = (0:290);
cd ../harishankar_matlab

figure(1);
fig = figure(1);
clf
colormap('hot');
pcolor(x1dv,ts(1:291),dissint'),shading flat, colorbar;,%caxis([0 1]*5e-3);
xlabel('x (m)')
ylabel('time (s)')
title('Vertical integral of Viscous dissipation')
print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/ke_vs_t290s.jpg'));

