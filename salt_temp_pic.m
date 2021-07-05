%% This is a basic comparison plot for comparing the inviscid and viscous
%% cases

% Set the output number here
iis = [245:5:300];
%iis=[120 140 160 180 200 220 240 260 280 300];
%iis=50;

% read in the grids i stands for inviscid, v for viscous
cd ../heatsalt32drealshortinv
spinsgrid2d
x1di=x1d;z1di=z1d;
cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% use the initial data to set bounds
ii=0;
t0v=spins_reader_new('t',ii);
s0v=spins_reader_new('s',ii);
mxt=max(t0v);
mnt=min(t0v);
mxs=max(s0v);
mns=min(s0v);

% loop over outputs
mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    s=spins_reader_new('s',ii);
    t=spins_reader_new('t',ii);
    figure(fi);
    fig = figure(fi);
    clf
    colormap darkjet
    subplot(2,2,1);
    pcolor(x1dv,z1dv,s'),shading flat,caxis(subplot(2,2,1),[0 6]);
    ylabel('z (m)')
    title('s (viscous top, inviscid bot)')
    subplot(2,2,2);
    pcolor(x1dv,z1dv,t'),shading flat, caxis(subplot(2,2,2),[5 20]);
    title('T (viscous top, inviscid bot)')
    cd ../heatsalt32drealshortinv
    s=spins_reader_new('s',ii);
    t=spins_reader_new('t',ii);
    subplot(2,2,3);
    pcolor(x1di,z1di,s'),shading flat, caxis(subplot(2,2,3),[0 6]);
    ylabel('z (m)')
    xlabel('x (m)')
    subplot(2,2,4);
    pcolor(x1di,z1di,t'),shading flat, caxis(subplot(2,2,4),[5 20]);
    xlabel('x (m)')
    pos1 = get(subplot(2,2,1), 'Position'); 
    pos2 = get(subplot(2,2,2), 'Position');
    pos3 = get(subplot(2,2,3), 'Position');
    pos4 = get(subplot(2,2,4), 'Position');
    %colorbar('Position',[pos4(1)+pos4(3)+0.01 pos4(2) 0.025 pos4(4)*2.4]),caxis([5 20]);
    %colorbar('Position',[pos3(1)+pos3(3)+0.01 pos3(2) 0.025 pos3(4)*2.4]),caxis([0 6]);
    cd ../heatsalt32drealshort
    print(fig,'-djpeg',sprintf('../harishankar_matlab/Plots/Salt_temperature/time_%d.jpg',ii))
  end
  cd ../harishankar_matlab
