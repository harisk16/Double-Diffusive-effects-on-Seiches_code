 %% This script creates data for Hovmoller plots near the boundary

cd ../heatsalt32drealshortinv
spinsgrid2d
z1di=z1d;z1di=z1d;
for ii=0:100
    spinsread2dnewts
    keneartopi(:,ii+1)=ke(:,708);
    sneartopi(:,ii+1)=s(:,708);
    tneartopi(:,ii+1)=t(:,708);
end
%[aa myind]=min(abs(z1d-0.005))
cd ../heatsalt32drealshort
spinsgrid2d
z1dv=z1d;z1dv=z1d;
for ii=0:100
    spinsread2dnewts
    keneartopv(:,ii+1)=ke(:,630);
    sneartopv(:,ii+1)=s(:,630);
    tneartopv(:,ii+1)=t(:,630);
end
%[aa myind]=min(abs(z1d-0.005))
cd ../harishankar_matlab
ts=(0:300);
save myneartophov_info x1d ts keneartopi sneartopi tneartopi keneartopv sneartopv tneartopv
