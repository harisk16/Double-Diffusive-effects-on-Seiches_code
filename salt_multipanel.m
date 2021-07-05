% This plots the salt concentration at different times in a single plot
clear all;

% Set the time at which plots are required (Use 9 points at a time)
iis = [5:5:45];

% Read the viscous cases

cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

figure(1);
fig = figure(1);
clf

% Plot over all iis
mylen=length(iis);
for fi=1:mylen
	ii=iis(fi);
	s=spins_reader_new('s',ii);

	colormap darkjet
	subplot(3,3,fi);
	pcolor(x1dv,z1dv,s'),shading flat,caxis(subplot(3,3,fi),[0 6]);
	if fi == 1 | fi == 4 | fi == 7
		ylabel('z (m)')
	end
	if fi == 7 | fi == 8 | fi == 9
		xlabel('x (m)')
	end
	title(ii + "s")
    hold on
end

print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/Salt_temperature/salt_time_5_to_45s.jpg'))
cd ../harishankar_matlab

