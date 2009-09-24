%
%########################################################################
%#  plot of Craya-Herring projection spectra from *.spec_ch
%########################################################################
%Lz = 1;
Lz = 1; % default is 1


namedir ='~kurien/INCITE_runs/SW02_tests/bous128_Fr0.21/';
name = 'bous128_Fr0.21_all';

%namedir ='~kurien/INCITE_runs/SW02_tests/bous128_Ro21Fr0.21/';
%name = 'bous128_Ro21Fr0.21_all';

%namedir ='~kurien/INCITE_runs/SW02_tests/bous128_Ro2.1Fr0.21/';
%name = 'bous128_Ro2.1Fr0.21_all';

%namedir ='~kurien/INCITE_runs/RemSukSmi09_tests/lowres/mauler/f136b681/';
%name = 'bous200Lz0.2_all';

%namedir ='~kurien/INCITE_runs/RemSukSmi09_tests/lowres/mauler/f27b136/';
%name = 'bous200Lz0.2_all';

namedir ='~kurien/INCITE_runs/RemSukSmi09_tests/lowres/';
%name = 'lowres2_all';
%name = 'lowres2d0.1_all';
%name = 'lowres2d0.1pi2_all';
name = 'l400_d0.1_all';
%name = 'lowres3_all';

namedir ='~kurien/INCITE_runs/Intrepid/RSS09_tests/aspect/';
%name = 'aspect_all';
%name = 'aspectd1_all';
%name = 'aspectd10_all';
%name = 'aspect_newU_all';
name = 'aspect_newUd1_all';  %this is the run that matches RemSukSmi09 upto the correct damping
Lz=0.2;epsf=1;kf = 4;

%namedir ='~/INCITE_runs/Intrepid/RSS09_tests/uvwforce/';
%name = 'rssuvw_all';

%namedir ='~kurien/INCITE_runs/Intrepid/lowaspect_bous/';
%namedir = '~kurien/INCITE_runs/Intrepid/lowaspect_bous/nodamp/';
namedir = '~kurien/INCITE_runs/Intrepid/lowaspect_bous/hyper4/';
%namedir = '~kurien/INCITE_runs/Intrepid/lowaspect_bous/shift_force/';
%name = 'n1600_d0.2_Ro0.05_all';  
%Lz=0.2;epsf=1;kf = 10;
name = 'n1600_d0.2_Ro0.05hy4_0002.8500';
Lz=0.2;epsf=1;kf = 4;

% plot all the spectrum:
movie=1;


spec_r_save=[];
spec_r_save_fac3=[];

fid=fopen([namedir,name,'.spec_ch'],'r','b'); %use 'b' for intrepid data which is bigendian


spec_tot = [];
spec_Q_tot = [];
spec_wave = [];
spec_vort = [];
spec_kh0 = [];

[time,count]=fread(fid,1,'float64');
j = 0;
while (time >=.0 & time <= 100)
if (count==0) 
   disp('error reading spec_ch file')
end

time
  n_r=fread(fid,1,'float64');
  spec_tot=fread(fid,n_r,'float64');
  spec_Q_tot=fread(fid,n_r,'float64');
  spec_vort=fread(fid,n_r,'float64');
  spec_wave=fread(fid,n_r,'float64');
  spec_kh0=fread(fid,n_r,'float64');


k = [0:n_r-1];

if (movie)
%pause
exp = 0;
figure(1); % +, - and total and projected energy spectra
loglog(k,spec_tot.*k'.^exp,'k'); hold on;
%loglog(k,spec_Q_tot,'bo'); hold on;
%loglog(k,spec_tot./spec_Q_tot,'ko');hold on;
loglog(k,spec_vort.*k'.^exp,'b'); hold on;
loglog(k,spec_wave.*k'.^exp,'r'); hold on;
%loglog(k,spec_kh0,'c');hold on; 
axis([1 1000 1e-6 1]);
grid
legend('total','vortical','wave')
hold off
%pause

figure(2) ;
te = sum(spec_tot);
tvort = sum(spec_vort);
twave = sum(spec_wave);
tsk = (epsf*(2*pi*kf/Lz)^2)^(1/3);
tls = (epsf*(kf^2))^(1/3);
esk = (epsf/(2*pi*kf/Lz))^(-2/3);
els = (epsf/kf)^(-2/3);
esk/els
tsk/tls
plot(time*tsk/tls, te*esk/els,'kx'); hold on;
plot(time*tsk/tls, tvort*esk/els,'b.'); hold on;
plot(time*tsk/tls, twave*esk/els,'ro'); hold on;
legend('total','vortical','wave');

end % end movie loop

[time,count]=fread(fid,1,'float64');

end

