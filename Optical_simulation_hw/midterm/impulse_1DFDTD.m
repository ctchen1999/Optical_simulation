% Midterm quiz problem 3(1)
clc; clear; close all;
%% Setting
format long
x.dim=200;
x.source = 100;
x.direction = "positive";
x.amplitude = 1;
S = 1; % Stability
c = 3e8;
delta = 1e-6;
delta_t = S*delta / c;

% basic parameters of E and H
sigma = zeros(1, x.dim);
epsilon0=(1/(36*pi))*1e-9;
mu0=4*pi*1e-7;
epsr = ones(1,x.dim);
epsr(1:10) = 1e10; epsr(end-10:end) = 1e10;
ae = ones(1, x.dim)*delta_t/epsilon0./epsr;
ae = ae./(1+delta_t*(sigma./epsr)/(2*epsilon0));
mur = ones(1,x.dim);
mur(1:10) = 1e-10; mur(end-10:end) = 1e-10;
am = ones(1, x.dim)*delta_t/mu0./mur;

figure(1)
subplot(1,2,1);
plot(1:200, epsr);
title("\epsilon_{relative} of space")
xlabel("x"); ylabel("\eps")
xlim([-5 205])

subplot(1,2,2);
plot(1:200, mur);
title("\mu_{relative} of space")
xlabel("x"); ylabel("\mu")
xlim([-5 205])

Ez = zeros(1, x.dim);
Hy = zeros(1, x.dim);

%%
F = []; % frame restore
Niter = 600;
figure(2)
Ez(x.source) = x.amplitude; % initial x.source
for n=1:Niter
    if 3 < x.source && x.source < x.dim-3 && x.direction == "positive"
        x.source = x.source + 1;
    elseif 3 < x.source && x.source <= x.dim-3 && x.direction == "negative"
        x.source = x.source - 1;
    elseif x.source == x.dim-3 && x.direction == "positive"
        x.direction = "negative";
    elseif x.source == 3 && x.direction == "negative"
        x.source = x.source + 1;
        x.direction = "positive";
    end
%%%%%% 碰到boundary反轉 %%%%%%
    if x.direction == "positive"
        Ez(x.source) = x.amplitude;
    elseif x.direction == "negative"
        Ez(x.source) = -x.amplitude;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    n1 = x.source - 2;
    n2 = x.source + 2;

%     fprintf("x.source is %d\n", x.source)
    Hy(n1:n2) = Hy(n1:n2) + am(n1:n2).*(Ez(n1+1:n2+1) - Ez(n1:n2));
    Ez(n1:n2) = Ez(n1:n2) + ae(n1:n2).*(Hy(n1+1:n2+1) - Hy(n1:n2));
    
    plot(1:x.dim, Ez)
    xlabel("x_{position}"); ylabel("E_z")
    title("1D FDTD Gaussian source with outer boundary at " + n + " iteration")
    set(gca, "FontSize", 12)
    axis([0 200 -1.2 1.2])
    drawnow
    Ez = zeros(1, x.dim);
    Hy = zeros(1, x.dim);
    F = [F getframe(gcf)];
end

%% gif
name = "20221128_1DFDTD_Gaussian pulse_陳政霆.gif";
for j = 1:length(F)   
    [image,map]=frame2im(F(j));
    [im,map2]=rgb2ind(image,128);

    if j==1
        imwrite(im,map2,name,'gif','writeMode','overwrite','delaytime',0,'loopcount',inf);
    else
        imwrite(im,map2,name,'gif','writeMode','append','delaytime',0);
    end
end
