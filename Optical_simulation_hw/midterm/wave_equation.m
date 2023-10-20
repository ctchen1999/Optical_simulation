clc;clear;close all;
%%
lambda = 500e-9;
c = 3e8;
freq = c/lambda;
w = 2*pi*freq;
dx = lambda/20;
A = 1; %可以改看看比1小或是比1大
dt = A*dx/c;
u = zeros(1,102); %空間總長
M = [];

for t = 2:400
    u(t,1) = sin(w*(t-1)*dt);
    u(t+1,2:101) = A^2*(u(t,3:102)+u(t,1:100)-2*u(t,2:101))+2*u(t,2:101)-u(t-1,2:101);
    plot(u(t,:));
    axis([1 100 -2 2]);
    title('sinusoidal wave propagation model');
    M = [M, getframe(gcf)];
end

name =  'standingwave.gif';

for j = 1:length(M)   
    [image,map]=frame2im(M(j));
    [im,map2]=rgb2ind(image,128);

    if j==1
        imwrite(im,map2,name,'gif','writeMode','overwrite','delaytime',0,'loopcount',inf);
    else
        imwrite(im,map2,name,'gif','writeMode','append','delaytime',0);
    end
end
