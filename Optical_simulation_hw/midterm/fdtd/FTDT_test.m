clc; clear all;

max_time = 40;
max_space = 200;
x = linspace(1,201,201);

mu = pi*4e-7;
elp = 8.85e-12;
c = sqrt(1/mu/elp);
wavelength = 500e-9;
freq = c/wavelength;

dx = wavelength/20;
dy = dx;
dt = 1/c*((1/dx)^2+(1/dy)^2)^-0.5;

Ex = zeros(max_space+1,1);
Hy = zeros(max_space+1,1);
 
Eeta=dt/dx/elp;     
Heta=dt/dx/mu;      
wave_imp = sqrt(mu/elp);

%Gaussian Source
t0=100;                                                    
spread=10;                                                 
Ex(2:max_space,1)= exp(-(t0-(2:max_space)).^2/spread^2);
% Hy = -(1/wave_imp)*Ex;
for t = 1:100
Ex(2:max_space) = Ex(2:max_space) - Eeta*(-Hy(1:max_space-1)+Hy(2:max_space));
Hy(1:max_space-1) = Hy(1:max_space-1) - Heta*(-Ex(1:max_space-1)+Ex(2:max_space));

plot(Ex);
axis([0 200 -1 1]);
pause(0.05);
end