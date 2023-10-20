close all;
clear all;
clc;
%Grid Dimension in x (xdim) direction
c = 3e8;
freq_in=3e7;% Hz
eps_r = 1;
lamda = (c/freq_in)/sqrt(eps_r);
a=1;
xdim = 100;
dx = lamda/10; % x-step
x = 0:dx:xdim ; 
xsteps = length(x);
%Total time
time_tot=150;
Rx = 0.5; % courant constant of stability R < 1 => dispersion, R > 1 => unstability
c = 3e8; 
dt = Rx*dx/c;
tsteps = time_tot;
%Grid Dimension in y (ydim) direction
ydim = 100;
Ry = 0.5;
dy = c*dt/Ry;
y = 0:dy:ydim ; 
ysteps = length(y);
[y x]=meshgrid(y,x);
% Rain setting(number position)
no_rain=1;
delta_rain=floor(time_tot/no_rain);
xsource=randperm(xsteps);
ysource=randperm(ysteps);
source=zeros(2,no_rain);
source(1,1:no_rain)=xsource(1:no_rain);
source(2,1:no_rain)=ysource(1:no_rain);
source(1,1)=floor(xsteps/2);source(2,1)=floor(ysteps/2);
% Initialization of field vectors
Ez=zeros(ysteps,xsteps);
Hx=zeros(ysteps,xsteps);
Hy=zeros(ysteps,xsteps);
Ex2=zeros(tsteps,xsteps);
Exlast_1=zeros(tsteps,xsteps);
Ey2=zeros(tsteps,ysteps);
Eylast_1=zeros(tsteps,ysteps);
for n = 1+ceil(1/min(Rx,Ry)):tsteps
 %% FDTD   
 
for l = 1: xsteps
    for m = 1:ysteps-1
   Hx(m,l) = Hx(m,l)-Ry*(Ez(m+1,l)-Ez(m,l));
    end
end
for m1 = 1: ysteps
    for l1 = 1:xsteps-1
   Hy(m1,l1) = Hy(m1,l1)+Rx*(Ez(m1,l1+1)-Ez(m1,l1));
    end
end
for m2 = 2: ysteps
    for l2 = 2:xsteps
   Ez(m2,l2) = Ez(m2,l2)+Rx*(Hy(m2,l2)-Hy(m2,l2-1))-Ry*(Hx(m2,l2)-Hx(m2-1,l2));
    end
end
%% absorbing boundary condition
% in x-direction
    Ex2(n,:) = Ez(:,2);  
    Ez(:,1)= Ex2(n-1/Rx,:);
    Exlast_1(n,:) = Ez(:,xsteps-1);
    Ez(:,xsteps) = Exlast_1(n-1/Rx,:);
    
% in y-direction
    Ey2(n,:) = Ez(2,:);  
    Ez(1,:)= Ey2(n-1/Ry,:);
    Eylast_1(n,:) = Ez(ysteps-1,:);
    Ez(ysteps,:) = Eylast_1(n-1/Ry,:);

%% Sine source
    %pulse=sin(((2*pi*(freq_in)*n*dt)));
    pulse =exp(-(n-10)^2/20);
    pulse_1 =exp(-(n-30)^2/20);
    pulse_2 =exp(-(n-50)^2/20);
    pulse_3 =exp(-(n-70)^2/20);
    pulse_4=exp(-(n-90)^2/20);
    
    Ez(50,50)=Ez(50,50)+pulse;
    Ez(25,25)=Ez(25,25)+pulse_1;
    Ez(75,75)=Ez(75,75)+pulse_2;
    Ez(75,25)=Ez(75,25)+pulse_3;
    Ez(25,75)=Ez(25,75)+pulse_4;
%% Assigning source
% position of source
%if rem((n-3)/delta_rain,1)==0
%    i=(n-3)/delta_rain+1;

%    Ez(source(1,i),source(2,i)) = Ez(source(1,i),source(2,i))+pulse;
%    n
%end

%% Plotting Ez-wave
figure
set(gcf,'color','w');
set(gcf,'Renderer','Zbuffer');
%% Visualization
    surf(x,y,Ez);
    zlim([-0.5 0.5])
    caxis([-1 1])
%    drawnow
%     titlestring=['2D FDTD at time step =',num2str(n)];
%     title(titlestring,'fontweight','bold');
    xlabel('x (m)','fontweight','bold')
    ylabel('y (m)','fontweight','bold')
    zlabel('water surface height (m)','fontweight','bold')
    getframe;
    frames(a)=getframe(gcf); %以getframe將每次的圖存進frames中
    close all;
    a=a+1;
    end
dt=0.05; 
for n=1:140
    [image,map]=frame2im(frames(n));
    [im,map2]=rgb2ind(image,128);
    if n==1
        imwrite(im,map2,'move_1.gif','gif','writeMode','overwrite','delaytime',0.5,'loopcount',inf);
    else
        imwrite(im,map2,'move_1.gif','gif','writeMode','append','delaytime',dt);
    end
end

    