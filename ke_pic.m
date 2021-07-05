%% This is a basic comparison plot for comparing the inviscid and viscous
%% cases

% Set the output number here
iis=[120 140 160 180 200 220 240 260 280 300];
%iis=10;

% read in the grids i stands for inviscid, v for viscous
cd ../heatsalt32drealshortinv
spinsgrid2d
x1di=x1d;z1di=z1d;
cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    spinsread2dnewts
    kevmax=max(ke(:));
    figure(fi);
    fig = figure(fi);
    clf
    colormap darkjet
    subplot(2,1,1)
    pcolor(x1dv,z1dv,ke'),shading flat,colorbar
    caxis([0 1]*kevmax)
    ylabel('z (m)')
    title('KE (viscous top, inviscid bot')
    cd ../heatsalt32drealshortinv
    spinsread2dnewts
    subplot(2,1,2)
    pcolor(x1di,z1di,ke'),shading flat,colorbar
    caxis([0 1]*kevmax)
    ylabel('z (m)')
    xlabel('x (m)')
    %print('figure','-djpeg')
    cd ../heatsalt32drealshort
    print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/KE/time_%d.jpg',ii))
end
  cd ../harishankar_matlab
