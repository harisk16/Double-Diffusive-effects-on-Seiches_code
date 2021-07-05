%% Compares the integral of total KE between inviscid, viscous and no double diffusion
%% cases

% Set the output number here
iis=[0:1:290];

cd ../heatsalt32drealshortinv
spinsgrid2d

% Find dimensions
Nx = NX;
Nz = NZ;
Lz = max(z1d(:));
Lx = max(x1d(:));

% Define parameters for integration

[zic,wic]=clencurt(NZ-1);

% since -1<zc<1 we need the factors for chain rule
z=Lz*(zic+1)/2;
dzcdz=2/Lz;
dzdzc=Lz/2;
wi=wic*dzdzc;



% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    cd ../heatsalt32drealshortinv
	spinsgrid2d
    spinsread2dnewts
    ketoti(ii+1)= sum(ke(:));
    
    cd ../heatsalt32drealshort
	spinsgrid2d
	spinsread2dnewts
    % Loop over x and integrate dissipation over z
		for x_pt = 1:Nx 
			keatx = ke(x_pt,:);
            transpose = keatx';
			keintvdd(x_pt,ii+1) = (wi*transpose);
		end
	ketotvdd(ii+1) = sum(keintvdd(:,ii+1));
	
    cd ../heatsalt32drealshortnodd
	spinsgrid2d
	spinsread2dnewts
    % Loop over x and integrate dissipation over z
		for x_pt = 1:Nx 
			keatx = ke(x_pt,:);
            transpose = keatx';
			keintvnodd(x_pt,ii+1) = (wi*transpose);
		end
	ketotvnodd(ii+1) = sum(keintvnodd(:,ii+1));
    
end
  cd ../harishankar_matlab
  
  ketoti = ketoti*Lx*Lz/((Nx)*(Nz));
  ketotvdd = ketotvdd*Lx/(Nx);
  ketotvnodd = ketotvnodd*Lx/(Nx);
  
%% Plot KEs in a single graph with time

iis_new = linspace(iis(1),iis(end),1000*length(iis));

ketoti_1000 = interp(ketoti,1000);
ketotvdd_1000 = interp(ketotvdd,1000);
ketotvnodd_1000 = interp(ketotvnodd,1000);

[pks_i, locs_i] = findpeaks(ketoti_1000);
[pks_vdd, locs_vdd] = findpeaks(ketotvdd_1000);
[pks_vnodd, locs_vnodd] = findpeaks(ketotvnodd_1000);

period_i = locs_i(2:19) - locs_i(1:18);
period_vdd = locs_vdd(2:19) - locs_vdd(1:18);
period_vnodd = locs_vnodd(2:18) - locs_vnodd(1:17);
set(groot,'defaultLineLineWidth',1)


figure(1);
fig = figure(1);

clf
plot(locs_i(1:19)/1000,ketoti_1000(locs_i(1:19))/ketoti_1000(locs_i(1))); hold on;
plot(locs_vdd(1:19)/1000,ketotvdd_1000(locs_vdd(1:19))/ketotvdd_1000(locs_vdd(1))); hold on;
plot(locs_vnodd(1:18)/1000,ketotvnodd_1000(locs_vnodd(1:18))/ketotvnodd_1000(locs_vnodd(1))); hold off;
title('Normalized max KE');
xlabel('Time (s)')
ylabel('Normalized max KE')
legend({'Inviscid','Viscous dd','Viscous nodd'})
print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/maxke_lineplot.jpg'));


figure(2);
fig = figure(2);
clf
plot(iis_new,ketoti_1000); hold on;
plot(iis_new,ketotvdd_1000); hold on;
title('Total KE');
plot(iis_new,ketotvnodd_1000); hold off;

ylabel('Total KE');
xlabel('Time (s)');
legend({'Inviscid','Viscous dd','Viscous nodd'})
print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/ke_lineplot.jpg'));

figure(3);
fig = figure(3);
clf
plot(locs_i(1:18)/1000,period_i/1000); hold on;
plot(locs_vdd(1:18)/1000,period_vdd/1000); hold on;
plot(locs_vnodd(1:17)/1000,period_vnodd/1000); hold off;
title('Period of KE');
xlabel('Time (s)')
ylabel('Period of KE (s)')
%legend({'Inviscid','Viscous dd','Viscous nodd'})
print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/period_ke_lineplot.jpg'));

