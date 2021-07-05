%% This creates a movie out of plots

clear all;

% Set the output number here
iis = [0:1:10];

cd ../heatsalt32drealshortinv
spinsgrid2d
x1di=x1d;z1di=z1d;

v = VideoWriter('Salt_inv.avi');
open(v);

mylen=length(iis);
for fi=1:mylen
    ii=iis(fi);
    s=spins_reader_new('s',ii);
    
    figure(fi);
    clf
    %colormap('hot');
    %subplot(1,1,1);
    colormap darkjet
    pcolor(x1di,z1di,s'),shading flat, colorbar,caxis([0 6]);
    xlabel('x (m)')
    ylabel('z (m)')
    title('Salt')
    
    frame = figure(fi);
	writeVideo(v,frame);
	
end

cd ../harishankar_matlab
close(v);  
  
