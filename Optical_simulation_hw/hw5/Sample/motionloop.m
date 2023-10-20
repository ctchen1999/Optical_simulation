clear;clc;close all;
v = zeros(300);
v_tmp = v;
x_max = size(v,2) ; y_max = size(v,1);
x_mid = x_max/2   ; y_mid = y_max/2;


delta = 1;
while delta > 0.001
    v(2:end-1,2:end-1) = 0.25 * (v(1:end-2,2:end-1)+v(3:end,2:end-1)+v(2:end-1,1:end-2)+v(2:end-1,3:end));
%====================Loop Boundary====================
    for i = 1:x_max
        for j = 1:y_max
            if sqrt((i-x_mid)^2+(j-y_mid)^2) > 130
                v(j,i) = 0.1;
            end
        end
    end
%=======================================================

%====================Square   Boundary====================
%     v(1,:) = 0.1;
%     v(end,:) = 0.1;
%     v(:,1) = 0.1;
%     v(:,end) = 0.1;
%=======================================================

    delta = max(max(v-v_tmp))
    v_tmp = v;

end


[fx,fy] = gradient(v);
fx = -fx ; fy = -fy ;
q = 1.6e-19 ; %1.6e-19
m = 1.67e-27 ; %9.1e-31
vx = 0. ; vy = 12.5;
sx = 50 ; sy = 150;
sx_total = [sx] ; sy_total = [sy];
dt = 0.001;
t_end = 100000;
speed = 1000;
M = [];
for t = 1:t_end
    if round(sx) >= x_max | round(sy) >= y_max | round(sx) <= 0 | round(sy) <= 0
        disp("Escape");
        break
    end
    ax = fx(round(sy),round(sx))*q/m ; ay = fy(round(sy),round(sx))*q/m;
    sx = sx + vx*dt +  0.5*ax*(dt^2)   ; sy = sy + vy*dt +  0.5*ay*(dt^2);
    vx = vx + ax*dt ; vy = vy + ay*dt;
    sx_total = [sx_total,sx] ; sy_total = [sy_total,sy];

    if mod(t,speed) == 0
        hold off;
        surf(v);     view([0,90]); 
        colorbar;     caxis([-0.1 0.1]);
        colormap jet; axis image;  
        grid off;                           
        shading interp;
        axis([0 x_max 0 y_max]);
        title({['Single Particle Motion in Electric Fields  '];['time =',num2str(t*dt,'%6.2f'),'s']})
        hold on
        rectangle('Position',[sx_total(t)-2.5 sy_total(t)-2.5 5 5],'Curvature',[1 1],'FaceColor','blue')
        plot(sx_total(1:t),sy_total(1:t))
        ylabel(['Position (m)'])
        xlabel(['Position (m)'])
        M = [M,getframe(gcf)];
        fprintf('progressing...%1.2f%%\n',t/t_end*100)
    end


end


name = 'singleparticlemove_square.gif'

for j = 1:length(M)   
    [image,map]=frame2im(M(j));
    [im,map2]=rgb2ind(image,128);

    if j==1
        imwrite(im,map2,name,'gif','writeMode','overwrite','delaytime',0,'loopcount',inf);
    else
        imwrite(im,map2,name,'gif','writeMode','append','delaytime',0);
    end

end





