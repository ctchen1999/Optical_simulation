clc; clear; close all;
%% create parameter
q = 1.6e-19;
m = 9.1e-31;
v0 = 100; %initial velocity(m/s)
r = 0.1;%the circle radius you want electron round
d = -0.5:0.01:0.5;
[X,Y] = meshgrid(d,d);

%% Potential distribution
V = zeros(size(X));
f = 1;

F = m*v0^2/r;

%create circle
x1_0 = 0;
y1_0 = 0;
for theta = linspace(0,2*pi,50)
    x1 = x1_0+r*cos(theta);
    y1 = y1_0+r*sin(theta);
    x = 0; y = 0;
    d_x = abs(((F*cos(theta))*1)/q);  %calculater potential difference
    d_y = abs(((F*sin(theta))*1)/q);
 
    if (0 >= rad2deg(theta)) && (rad2deg(theta) <= 90)
        a = y+d_y ; b = y;   c = x;  d = x+d_x; 
       
    elseif (rad2deg(theta) > 90) && (rad2deg(theta) <= 180)
        a = y+d_y; b = y;   c = x+d_x;  d = x; 
        
    elseif (rad2deg(theta) > 180) && (rad2deg(theta) <= 270)
        a = y; b = y+d_y;   c = x+d_x;  d = x; 

    elseif (rad2deg(theta) > 270) && (rad2deg(theta) <= 360)
        a = y; b = y+d_y;   c = x;  d = x+d_x; 

    end

    V(:,1) = a;                 
    V(:,length(V)) = b;
    V(1,:) = c;
    V(size(V,1),:) = d;
    
    %calculate electric field 
    for it = 1:10000
        for i = size(V,1)-1:-1:2
            for j = size(V,2)-1:-1:2
                V(i,j) = (V(i+1,j)+V(i-1,j)+V(i,j+1)+V(i,j-1))/4;
            end
        end
    end
      
    %PLOT
    hold on
    [DX,DY] = gradient(V);
    plot(x1,y1,'.','MarkerSize', 12)
    quiver(X,Y,DX,DY,100);
    axis([-0.2 0.2 -0.2 0.2])
    drawnow
    frame(f) = getframe(gcf);
    f = f + 1;
    close all;
end
%% gif
% filename = 'electron_movement.gif';
% for i = 1:size(frame,2)
%     im = frame2im(frame(i));
%     [imind,cm] = rgb2ind(im,256);
%     if i == 1
%         imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%     else
%         % overwrite then change to append
%         imwrite(imind,cm,filename,'gif','WriteMode','append');
%     end
% end