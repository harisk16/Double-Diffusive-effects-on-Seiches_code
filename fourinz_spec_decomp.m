clear all;
cd ../heatsalt32drealshortinv
spinsgrid2d
iis =[150:1:290];

spec =zeros(1,14);
spectot = 0;
dz = Lz/NZ;

mylen =length(iis);
for fi =1:mylen
	ii = iis(fi);
	u =spins_reader_new('u',ii);
	w =spins_reader_new('w',ii);
	udoub=[u;-flipud(u)];
	wdoub=[w;flipud(w)];
	udoubf=fft(udoub);
	wdoubf=fft(wdoub);
	fullspec=udoubf.*conj(udoubf)+wdoubf.*conj(wdoubf);
	intfullspec=sum(fullspec,2)*dz;
	specmn=intfullspec(1);
	%spec1=intfullspec(2)+intfullspec(end);
	
	for m =2:15
		spec(m-1) = spec(m-1)+intfullspec(m+1) +intfullspec(end -(m-1));
	end

	spectot = spectot +sum(intfullspec(:));
	%spec1to10=sum(intfullspec(1:10))+sum(intfullspec(end-9:end));
	%spec11to20=sum(intfullspec(11:20))+sum(intfullspec(end-19:end-10));
	kdoub=[0:NX -NX+1:-1]*2*pi/(2*Lx); % I write it longhand

	%figure(1)
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
end

cd ../harishankar_matlab
spec =spec/spectot;
p =[2:15];
figure(1)
clf
bar(p,spec); axis([0 15 0 0.07])
xlabel('Wave number')
ylabel('Fraction of total')
print(figure(1),'-djpeg',sprintf('../harishankar_matlab/Plots/KE_spectrum/inv_dd_time_150_290s.jpg'))
