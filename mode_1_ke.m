clear all;


spectot =0;

iis = [0:1:290];
mylen=length(iis);
for fi=1:mylen
    ii = iis(fi);
    cd ../heatsalt32drealshort
	spinsgrid2d
    u = spins_reader_new('u',ii);
    w = spins_reader_new('w',ii);
    udoub=[u;-flipud(u)];
    wdoub=[w;flipud(w)];
    udoubf=fft(udoub,[],1);
    wdoubf=fft(wdoub,[],1);
    fullspec=udoubf.*conj(udoubf)+wdoubf.*conj(wdoubf);
    sz=size(x);
    Nz=sz(2);
    Nx=sz(1);
    [zic,wic]=clencurt(Nz-1);
    dzdzc=0.5*Lz;
    dzcdz=1/dzdzc;
    wi=reshape(wic*dzcdz,Nz,1);
    intfullspec=fullspec*wi;
    spec1dd(fi)=intfullspec(2)+intfullspec(end);
    spectotdd(fi) = sum(intfullspec(:));
    
    cd ../heatsalt32drealshortnodd
	spinsgrid2d
    u = spins_reader_new('u',ii);
    w = spins_reader_new('w',ii);
    udoub=[u;-flipud(u)];
    wdoub=[w;flipud(w)];
    udoubf=fft(udoub,[],1);
    wdoubf=fft(wdoub,[],1);
    fullspec=udoubf.*conj(udoubf)+wdoubf.*conj(wdoubf);
    sz=size(x);
    Nz=sz(2);
    Nx=sz(1);
    [zic,wic]=clencurt(Nz-1);
    dzdzc=0.5*Lz;
    dzcdz=1/dzdzc;
    wi=reshape(wic*dzcdz,Nz,1);
    intfullspec=fullspec*wi;
    spec1nodd(fi)=intfullspec(2)+intfullspec(end);
    spectotnodd(fi) = sum(intfullspec(:));
    
    cd ../heatsalt32drealshortinv
	spinsgrid2d
	u =spins_reader_new('u',ii);
	w =spins_reader_new('w',ii);
	udoub=[u;-flipud(u)];
	wdoub=[w;flipud(w)];
	udoubf=fft(udoub);
	wdoubf=fft(wdoub);
	fullspec=udoubf.*conj(udoubf)+wdoubf.*conj(wdoubf);
	intfullspec=sum(fullspec,2)*dz;
	specmn=intfullspec(1);
	spec1inv=intfullspec(2)+intfullspec(end);
	spectotinv(fi) = sum(intfullspec(:));

end 
cd ../harishankar_matlab

%% Line plot of mode 1 and total Ke spectrum

figure(1)
clf
plot(iis,spec1_new,'-');

plot(iis,spec1inv,'r'); hold on;
title('Total KE: red-inv, green-dd, blue-no dd');
plot(iis,spec1dd, 'g'); hold on;
plot(iis,spec1nodd, 'b'); hold off;
ylabel('Mode 1 KE spectrum');
xlabel('Time (s)');


