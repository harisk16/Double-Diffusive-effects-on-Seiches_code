% This will calculate the verical integral of dissipation
clear all; 
cd ../heatsalt32drealshort
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

for ii=1:50
    diss0v=spins_reader_new('diss',ii);
    % Loop over x and integrate dissipation over z
		for x_pt = 1:Nx 
			dissatx = diss0v(x_pt,:);
            transpose = dissatx';
			dissint(x_pt,ii) = (wi*transpose)/Lz;
		end
    
end
ts = (0:250);
cd ../harishankar_matlab

figure(1);
fig = figure(1);
clf
colormap('hot');
pcolor(x1dv,ts(1:50),dissint'),shading flat, colorbar,caxis([0 1]*5e-3);
xlabel('x (m)')
ylabel('time (s)')
title('Vertical integral of Viscous dissipation')
print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/diss_vs_t50s.jpg'));

