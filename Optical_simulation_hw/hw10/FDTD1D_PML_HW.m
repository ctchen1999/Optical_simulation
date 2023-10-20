%--------clear all--------
clear;clc;close all;
%--------Wave (波速/波長/頻率)--------
ep0 = (8.854*10^-12);
mu0 = (4*pi*10^-7);
c0 = 1/sqrt(ep0*mu0);
wavelength = 264e-9;
f = c0/wavelength;
%--------Unit of Space & Time (單位長&單位時間)--------
% dx = wavelength/20;
dy = wavelength/20;
dt = 1/c0*((1/dy)^2)^-0.5;
%--------PML區域--------
pmln = 20;  %PML width
%--------Spatial Parameter Setting（空間的參數）--------
Y_max = 200; %Y軸總格數
Y_mid = round((Y_max+1)/2); %Y軸中點
%--------Time Parameter Setting（時間的參數）--------
nloops = 300; %Number of loops(總共的迴圈數)
gifspeed = 5; % 每n次loop取1張gif
%--------Source Parameter Setting（波源的參數）--------
width = 5; %波的寬
E0 = 0.5; %波源的強度
%--------Constants (介電係數/磁導率)--------
mur = ones(Y_max);
epr = ones(Y_max);
eps = ep0*epr;
mus = mu0*mur;
neta = sqrt(mu0/ep0);
%--------PML 吸收層設置--------
m = 3.5;                    
ref = 1e-8; 
sigy = 
sigy_max = 

for j= 1:1:pmln
    sigy(pmln+1-j) = 
    sigy(Y_max-pmln+j)= 
end               
sigsy = 
%--------PML Constants (PML衍生出的)--------

C = 
D = 
E = 
F = 


%--------Initialize Vectors (初始的電/磁場)--------
Ez=zeros(Y_max);
Hx=zeros(Y_max);
%--------Generating Outer Source (圈外波源)--------


for j = 1:Y_max
    Ez(j)=E0*exp(-((((j-Y_mid)^2)^(1/2))/sqrt(2)/width)^2);
    Hx = Ez.*dt/dy./mus;
end


%--------Start FDTD loop--------
M=[]; %初始化gif的暫存點

for t = 1:nloops


    Ez(2:end) = C(2:end).*Ez(2:end)-D(2:end).*(Hx(2:end)-Hx(1:end-1));
    Hx(1:end-1) = E(1:end-1).*Hx(1:end-1)-F(1:end-1).*(Ez(2:end)-Ez(1:end-1));

    
    if mod(t,gifspeed) == 0
        plot(Ez),axis([1 Y_max -E0 E0]);
        hold on;
        plot(Hx.*((mu0*mur)./(ep0*epr)).^(1/2));
        title(['-Y propagation  time = ',num2str(t*dt*1.e15,'%6.2f'),'fs'])
        ylabel('electric fieid')
        xlabel(['position (',num2str(dy),' m/1 unit)'])
        hold off;
        M = [M,getframe(gcf)];
        fprintf('progressing...%1.1f%%\n',t/nloops*100)
    end
end




%--------Gif Output （輸出）--------
name=['1DFDTD_PML_yourname.gif'];;
for j = 1:length(M)   
    [image,map]=frame2im(M(j));
    [im,map2]=rgb2ind(image,128);
    if j==1
        imwrite(im,map2,name,'gif','writeMode','overwrite','delaytime',0,'loopcount',inf);
    else
        imwrite(im,map2,name,'gif','writeMode','append','delaytime',0);
    end
end


