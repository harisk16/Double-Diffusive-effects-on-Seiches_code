load myneartophov_info
%Value of z chosen in hov_maker.m
z_val = 59;
sz = size(sneartopv);
sz
figure(1)
figs = figure(1);
clf
colormap darkjet
subplot(2,1,1)
pcolor(x1d,ts(1:101),sneartopv'),shading flat ,colorbar;
ylabel('time (s)')
h = title('Salt Hovmoller no-slip(top), free-slip(bottom)');
pos = get(h,'Position');
pos(2) = pos(2) + 6;
set( h, 'Position', pos);
subplot(2,1,2)
pcolor(x1d,ts(1:101),sneartopi'),shading flat,colorbar;
ylabel('time (s)')
xlabel('x (m)')
print(figs,'-djpeg',sprintf('/scratch/tilted_salt_group/harishankar_matlab/Plots/x_vs_t_0_100/salt_z_%d_mm.jpg',z_val))
figure(2)
figt = figure(2);
clf
colormap darkjet
subplot(2,1,1)
pcolor(x1d,ts(1:101),tneartopv'),shading flat,colorbar;
ylabel('time (s)')
h = title('Temperature Hovmoller no-slip(top), free-slip(bottom)');
pos = get(h,'Position');
pos(2) = pos(2) + 6;
set( h, 'Position', pos);
subplot(2,1,2)
pcolor(x1d,ts(1:101),tneartopi'),shading flat,colorbar;
ylabel('time (s)')
xlabel('x (m)')
print(figt,'-djpeg',sprintf('/scratch/tilted_salt_group/harishankar_matlab/Plots/x_vs_t_0_100/temp_z_%d_mm.jpg',z_val))
figure(3)
figke = figure(3);
clf
colormap hot
subplot(2,1,1)
pcolor(x1d,ts(1:101),keneartopv'),shading flat,colorbar;
ylabel('time (s)')
h = title('KE Hovmoller no slip (top), free slip (bottom)');
pos = get(h,'Position');
pos(2) = pos(2) + 6;
set( h, 'Position', pos);
subplot(2,1,2)
pcolor(x1d,ts(1:101),keneartopi'),shading flat,colorbar;
ylabel('time (s)')
xlabel('x (m)')
print(figke,'-djpeg',sprintf('/scratch/tilted_salt_group/harishankar_matlab/Plots/x_vs_t_0_100/ke_z_%d_mm.jpg',z_val))


