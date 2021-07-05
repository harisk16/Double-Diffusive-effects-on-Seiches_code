%% This is a basic comparison plot for comparing the inviscid and viscous
%% cases

% Set the output number here
iis = [26:1:34];
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
ii=0
u0v=spins_reader_new('u',ii);
w0v=spins_reader_new('w',ii);
mxu=max(u0v);
mnu=min(u0v);
mxw=max(w0v);
mnw=min(w0v);

% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    w=spins_reader_new('w',ii);
    u=spins_reader_new('u',ii);
    figure(fi);
    fig = figure(fi);
    clf
    colormap darkjet
    subplot(2,2,1)
    pcolor(x1dv,z1dv,w'),shading flat
    %caxis([-10*10^(-3) 10*10^(-3)]);
    ylabel('z (m)')
    title('w (viscous top, inviscid bot)')
    subplot(2,2,2)
    pcolor(x1dv,z1dv,u'),shading flat
    %caxis([-10*10^(-3) 10*10^(-3)]);
    title('u (viscous top, inviscid bot)')
    cd ../heatsalt32drealshortinv
    w=spins_reader_new('w',ii);
    u=spins_reader_new('u',ii);
    subplot(2,2,3)
    pcolor(x1di,z1di,w'),shading flat
    %caxis([-10*10^(-3) 10*10^(-3)]);
    ylabel('z (m)')
    xlabel('x (m)')
    subplot(2,2,4)
    pcolor(x1di,z1di,u'),shading flat
    %caxis([-10*10^(-3) 10*10^(-3)]);
    xlabel('x (m)')
    hp1 = get(subplot(2,2,1),'Position');
    hp2 = get(subplot(2,2,2),'Position');
    hp3 = get(subplot(2,2,3),'Position');
    hp4 = get(subplot(2,2,4),'Position');
    hp1_new = hp1; hp1_new(1) = hp1(1) - 0.03; set(subplot(2,2,1),'Position', hp1_new)
    hp2_new = hp2; hp2_new(1) = hp2(1) - 0.04; set(subplot(2,2,2),'Position', hp2_new)
    hp3_new = hp3; hp3_new(1) = hp3(1) - 0.03; set(subplot(2,2,3),'Position', hp3_new)
    hp4_new = hp4; hp4_new(1) = hp4(1) - 0.04; set(subplot(2,2,4),'Position', hp4_new)
    colorbar('Position',[hp4_new(1)+hp4_new(3)+0.025 hp4_new(2) 0.025 hp4_new(4)*2.4]);
    caxis([-10*10^(-3) 10*10^(-3)]);
    cd ../heatsalt32drealshort
    print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/Velocity/time_%d.jpg',ii))
  end
  cd ../harishankar_matlab