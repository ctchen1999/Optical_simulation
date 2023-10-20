clear; close all;

%% Parameters

L = 5; %domain length in meters
N = 505; % spatial samples in domain
Niter = 800; %# of iterations to perform
fs = 300e6; %source frequency in Hz
ds = L/N; %spatial step in meters
dt = ds/300e6; %"magic time step"
eps0 = 8.854e-12; %permittivity of free space
mu0 = pi*4e-7; %permeability of free space
x = linspace(0,L,N); %x coordinate of spatial samples

%% main
figure(1)
x = linspace(0,4*pi,101);
hold on
for i = 1:100
    plot(x, sin(x)+1)
    hold off
end