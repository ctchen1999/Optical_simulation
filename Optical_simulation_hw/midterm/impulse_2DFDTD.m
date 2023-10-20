% Midterm quiz problem 3(2)
clc; clear; close all;
%% Setting
format long
S = 1; % Stability
c = 3e8;
delta = 1e-6;
delta_t = S*delta / c;

x.dim=200;
x.source = 100;
y.dim=200;
y.source = 100;
[x.grid, y.grid] = meshgrid(x.dim, y.dim);

% Initialization of field matrices
Ez=zeros(x.dim,y.dim);
Hy=zeros(x.dim,y.dim);
Hx=zeros(x.dim,y.dim);

% basic parameters of E and H
sigma=4e-4*ones(x.dim,y.dim);
% sigma_star=4e-4*ones(xdim,ydim);
epsilon0=(1/(36*pi))*1e-9;
mu0=4*pi*1e-7;
epsr = ones(x.dim, y.dim);
epsr(1,:) = 1e10; epsr(end,:) = 1e10; epsr(:,1) = 1e10; epsr(:,end) = 1e10;
ae = ones(x.dim,y.dim)*delta_t/epsilon0./epsr;
ae = ae./(1+delta_t*(sigma./epsr)/(2*epsilon0));
mur = ones(x.dim,y.dim);
epsr(1,:) = 1e10; epsr(end,:) = 1e10; epsr(:,1) = 1e10; epsr(:,end) = 1e10;
mur(1,:) = 1e-10; mur(end,:) = 1e-10; mur(:,1) = 1e-10; mur(:,end) = 1e-10;
am = ones(x.dim,y.dim)*delta_t/mu0./mur;                   

%%
Niter=350;
F = [];
% Update loop begins
for n=1:1:Niter
    
    %if source is impulse or unit-time step 
    if gaussian==0 && sine==0 && n==1
        Ez(xsource,ysource)=1;
    end
    
    % Setting time dependent boundaries to update only relevant parts of the 
    % vector where the wave has reached to avoid unnecessary updates.
    if n<xsource-2
        n1=xsource-n-1;
    else
        n1=1;
    end
    if n<xdim-1-xsource
        n2=xsource+n;
    else
        n2=xdim-1;
    end
    if n<ysource-2
        n11=ysource-n-1;
    else
        n11=1;
    end
    if n<ydim-1-ysource
        n21=ysource+n;
    else
        n21=ydim-1;
    end
    
    %Vector update instead of for-loop for Hy and Hx fields
    Hy(n1:n2,n11:n21)=A(n1:n2,n11:n21).*Hy(n1:n2,n11:n21)+B(n1:n2,n11:n21).*(Ez(n1+1:n2+1,n11:n21)-Ez(n1:n2,n11:n21));
    Hx(n1:n2,n11:n21)=A(n1:n2,n11:n21).*Hx(n1:n2,n11:n21)-B(n1:n2,n11:n21).*(Ez(n1:n2,n11+1:n21+1)-Ez(n1:n2,n11:n21));
    
    %Vector update instead of for-loop for Ez field
    Ez(n1+1:n2+1,n11+1:n21+1)=C(n1+1:n2+1,n11+1:n21+1).*Ez(n1+1:n2+1,n11+1:n21+1)+D(n1+1:n2+1,n11+1:n21+1).*(Hy(n1+1:n2+1,n11+1:n21+1)-Hy(n1:n2,n11+1:n21+1)-Hx(n1+1:n2+1,n11+1:n21+1)+Hx(n1+1:n2+1,n11:n21));
    
    % Perfect Electric Conductor boundary condition
    Ez(1:xdim,1)=0;
    Ez(1:xdim,ydim)=0;
    Ez(1,1:ydim)=0;
    Ez(xdim,1:ydim)=0;
    
    % Source conditions
    if impulse==0
        % If unit-time step
        if gaussian==0 && sine==0
            Ez(xsource,ysource)=1;
        end
        %if sine
        if sine==1
            tstart=1;
            N_lambda=c/(frequency*delta);
            Ez(xsource,ysource)=sin(((2*pi*(c/(delta*N_lambda))*(n-tstart)*deltat)));
        end
        %if gaussian
        if gaussian==1
            if n<=42
                Ez(xsource,ysource)=(10-15*cos(n*pi/20)+6*cos(2*n*pi/20)-cos(3*n*pi/20))/32;
            else
                Ez(xsource,ysource)=0;
            end
        end
    else
        %if impulse
        Ez(xsource,ysource)=1;
    end
    
    %Movie type colour scaled image plot of Ez
    imagesc(delta*(1:1:xdim)*1e+6,(1e+6*delta*(1:1:ydim))',Ez',[-1,1]);colorbar;
    drawnow
    title('2D FDTD Gaussian source with outer boundary'); 
    set(gca, "FontSize", 12);
    F = [F getframe];
end

% name = "20221128_2DFDTD_Gaussian pulse_陳政霆.gif";
% for j = 1:length(F)   
%     [image,map]=frame2im(F(j));
%     [im,map2]=rgb2ind(image,128);
% 
%     if j==1
%         imwrite(im,map2,name,'gif','writeMode','overwrite','delaytime',0,'loopcount',inf);
%     else
%         imwrite(im,map2,name,'gif','writeMode','append','delaytime',0);
%     end
% end
