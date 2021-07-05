%% This is a basic comparison plot for comparing the inviscid and viscous
%% cases

% Set the output number here
iis = [255:5:300];
%iis=[120 140 160 180 200 220 240 260 280 300];
%iis=10;

% read in the grids i stands for inviscid, v for viscous
cd ../heatsalt32drealshortinv
spinsgrid2d
x1di=x1d;z1di=z1d;
cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% use the initial data to set bounds
ii=10;
diss0v=spins_reader_new('diss',ii);
vorty0v=spins_reader_new('vorty',ii);
mxdiss=max(diss0v);
mndiss=min(diss0v);
mxvorty=max(vorty0v);
mnvorty=min(vorty0v);

% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    diss=spins_reader_new('diss',ii);
    vorty=spins_reader_new('vorty',ii);
    figure(fi);
    fig = figure(fi);
    clf
    %colormap('hot');
    subplot(2,1,1);
    colormap(subplot(2,1,1),hot);
    pcolor(x1dv,z1dv,diss'),shading flat, colorbar,caxis([0 1]*5e-3);
    xlabel('x (m)')
    ylabel('z (m)')
    title('Viscous dissipation')
    %colormap darkjet;
    subplot(2,1,2);
    colormap(subplot(2,1,2),darkjet);
    pcolor(x1dv,z1dv,vorty'),shading flat, colorbar;
    xlabel('x (m)')
    ylabel('z (m)')
    title('Vorticity')
    %cd ../heatsalt32drealshortinv    
    print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/diss_vorty/time_%d.jpg',ii))
  end
  cd ../harishankar_matlab
