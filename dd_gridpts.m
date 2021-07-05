% This calculates the number of grid points effected by the double diffusive instability and multiplies by the Nx and Nz

clear all;

cd ../heatsalt32drealshort
spinsgrid2d
x1dv=x1d;z1dv=z1d;

% Determine the max and minimum value of density at t =0s
ii = 0;
s0v=spins_reader_new('s',ii);
t0v=spins_reader_new('t',ii);
rho0v = eqn_of_state(t0v,s0v);
mxrho = max(rho0v(:));
mnrho = min(rho0v(:));
mx_cutoff = 1.000001*(mxrho + 1000) - 1000;
mn_cutoff = 0.999999*(mnrho + 1000) - 1000;
% Set value of time at which analysis is to be done
ii = 50;
fi =1;
sv = spins_reader_new('s',ii);
tv = spins_reader_new('t',ii);
rhov_ii = eqn_of_state(tv,sv);

dummymx = (rhov_ii > mx_cutoff);
dummymn = (rhov_ii < mn_cutoff);

% Find dimensions
Nx = NX;
Nz = NZ;
Lz = max(z1d(:));
Lx = max(x1d(:));

% Define parameters for integration

[zic,wic]=clencurt(NZ-1);

% since -1<zc<1 we need the factors for chain rule
z=Lz*(zic+1)/2;
dzcdz=2/Lz;
dzdzc=Lz/2;
wi=wic*dzdzc;
dummy_totmx =0;
dummy_totmn =0;

% Loop over x and integrate dissipation over z
for x_pt = 1:Nx 
	dummymx = dummymx(x_pt,:);
	transposemx = dummymx';
	gridptsmx(x_pt) = (wi*transposemx);
	dummy_totmx = dummy_totmx + gridptsmx(x_pt);
	
	dummymn = dummymn(x_pt,:);
	transposemn = dummymn';
	gridptsmn(x_pt) = (wi*transposemn);
	dummy_totmn = dummy_totmn + gridptsmn(x_pt);
end

dummy_totmx = Lx*dummy_totmx/Nx;
dummy_totmx
fprintf('The value of the integral of grid points with density > max density for the viscous case is %f',dummy_totmx);

dummy_totmn = Lx*dummy_totmn/Nx;
dummy_totmn
fprintf('The value of the integral of grid points with density < min density for the viscous case is %f',dummy_totmn);

cd ../harishankar_matlab

