%% This is a basic comparison plot the difference between the inviscid and viscous

% Set the output number here
%iis = [26:1:34];
iis = 0;

cd ../heatsalt32drealshort
spinsgrid2d;
x1dv=x1d;z1dv=z1d;
spinsread2dnewts;
u_vis = u;

cd ../heatsalt32drealshortinv
spinsgrid2d;
x1di=x1d;z1di=z1d;
spinsread2dnewts;
u_inv = u;

for x=1:NX
	u_inv_x = u_inv(x,:);
	u_inter(x,:) = interp1(u_inv_x,z1dv);  
end

u_diff = u_vis - u_inter;

colormap darkjet
pcolor(x1dv,z1dv,u_diff'),shading flat
%caxis([-10*10^(-3) 10*10^(-3)]);
ylabel('z (m)')
xlabel('x (m)')
title('U difference (viscous -inviscid)')
