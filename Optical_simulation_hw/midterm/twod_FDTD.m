clc; clear; close all;
%%
c=3e8;
mu_0=4.0*pi*1.0e-7;
eps_0=1.0/(c.*c.*mu_0);
eps_r=1.0;
ie=201;
je=201;
is=floor(ie/2);
js=floor(je/2);c
%Electric and Magnetic field
Ez=zeros(ie,je);
Hx=zeros(ie,je);
Hy=zeros(ie,je);
nmax=400;
ddx=1.0e-3;
ddy=ddx;
dt=.98/(c*sqrt((1/ddx)^2+(1/ddy)^2));
%***************************************************
T=(0:1:nmax-1)'.*dt;
f_int=20.0e+9;%frequency in 20GHz
source=2.0*(2.0*pi*T.*f_int);%sine wave
%plot injected pulse
figure
plot(source)
title('source pulse: 20GHz sine wave');
pause(1);
[Emax]=max(source);
[Emin]=min(source);
C1=dt./(eps_0.*eps_r);
C2=dt/mu_0;
for n=1:nmax
%---------------update Ez--------------------------
for jj=2:je
    for ii=2:ie
        Ez(ii,jj)=Ez(ii,jj)+C1*((Hy(ii,jj)-Hy(ii-1,jj))./ddx-(Hx(ii,jj)-Hx(ii,jj-1))./ddy);
    end
end
%----------------inject source----------------
for ii=is-20:1:is+30
    Ez(ii,js)=source(n);
end
%--------------------Hx---------------------
for jj=1:je-1
    for ii=1:ie
        Hx(ii,jj)=Hx(ii,jj)-C2.*((Ez(ii,jj+1)-Ez(ii,jj))./ddy);
    end
end
%-------------------update Hy----------------------
for jj=1:je
    for ii=1:ie-1
        Hy(ii,jj)=Hy(ii,jj)+C2*((Ez(ii+1,jj)-Ez(ii,jj))./ddx);
    end
end
imagesc(Ez,0.5*[Emin Emax]);
%patch([jd jd],[1 id],'w');
%patch([jd jd],[id id],'w');
title('2D EM wave propagation : Multiple source');
colorbar;
colormap(jet);
pause(0.0002);
end