clear all;
cd ../heatsalt32drealshortnodd
spinsgrid2d


spec = zeros(1,14);
spectot =0;

iis = [0:1:50];
mylen=length(iis);
for fi=1:mylen
    ii = iis(fi);
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
    specmn=intfullspec(1);
    %spec1(fi)=intfullspec(2)+intfullspec(end);    
    
    for m=2:15
        spec(m-1)=spec(m-1)+ intfullspec(m+1) +intfullspec(end-(m-1));
    end
    
    spectot = spectot + sum(intfullspec(:));
    spec2to10(fi)=sum(intfullspec(3:10))+sum(intfullspec(end-9:end-1));
    spec11to20=sum(intfullspec(11:20))+sum(intfullspec(end-19:end-10));
    kdoub=[0:Nx -Nx+1:-1]*2*pi/(2*Lx); % I write it longhand

	%% Plot KE vs wave number over entire spectrum for every time step
    %figure(fi)
    %clf
    %subplot(2,1,1)
    %plot(kdoub,intfullspec,'bo-')
    %xlabel('k')
    %ylabel('KE spec')
    %axis([0 5e2 0 1e2])
    %subplot(2,1,2)
    %semilogy(kdoub,intfullspec)
    %xlabel('k')
    %ylabel('log scale KE spec')
    %print(figure(fi),'-djpeg',sprintf('../harishankar_matlab/Plots/KE_spectrum/vis_dd_time_%d.jpg',ii)) 
end 
cd ../harishankar_matlab

%% Time averaged bar graph of KE vs wave number 
spec =spec/spectot;
p =[2:15];
figure(1)
clf
bar(p,spec); axis([0 15 0 0.07])
xlabel('Wave number');
ylabel('Fraction of total');
print(figure(1),'-djpeg',sprintf('../harishankar_matlab/Plots/KE_spectrum/vis_nodd_time_0_50s.jpg'))

%% Plot each wave number in a single graph with time
%subplot(2,1,1)
%plot(iis,spec1,'r'); hold on;
%ylabel('Mode 1,2,3,4');
%title('KE spectrum vs time');
%subplot(5,1,2);
%plot(iis,spec2, 'g'); hold on;
%ylabel('Mode 2');
%subplot(5,1,3)
%plot(iis,spec3, 'b'); hold on;
%ylabel('Mode3');
%subplot(5,1,4)
%plot(iis,spec4, 'y'); hold on;
%ylabel('Mode 4');
%subplot(2,1,2)
%plot(iis,spec2to10,'r'); hold off;
%xlabel('Time (s)');
%ylabel('Mode 1 to 10');

