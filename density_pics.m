%% This is a basic comparison plot for comparing the inviscid and viscous
%% cases

% Set the output number here
%iis = [16:1:19];
%iis=[120 140 160 180 200 220 240 260 280 300];
iis=10;

% read in the grids i stands for inviscid, v for viscous
cd ../heatsalt32drealshortinv
spinsgrid2d
x1di=x1d;z1di=z1d;
cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% use the initial data to set bounds
ii=0
rho0v=spins_reader_new('rho',ii);
mxrho=max(rho0v);
mnrho=min(rho0v);

% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    rho=spins_reader_new('rho',ii);   
    figure(fi);
    fig = figure(fi);
    clf
    colormap darkjet
    subplot(2,1,1)
    pcolor(x1dv,z1dv,rho'),shading flat,colorbar
    ylabel('z (m)')
    title('w (viscous top, inviscid bot)')
    cd ../heatsalt32drealshortinv
    rho=spins_reader_new('rho',ii);
    subplot(2,1,2)
    pcolor(x1di,z1di,rho'),shading flat,colorbar
    ylabel('z (m)')
    xlabel('x (m)')  
    cd ../heatsalt32drealshort
    %print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/Density/time_%d.jpg',ii))
  end
  cd ../harishankar_matlab