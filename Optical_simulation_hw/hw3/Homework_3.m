clc;
close all;
clear;
% Some basic physics values for the stone:
Alpha = 65;   % angle at which it starts falling
g = 9.81;   % gravity
m = 10;      % mass of the stone
h = 25;      % height from the surface

%boundary conditions:
B_x = 0;
B_y = 0;

B1_x = h/tand(Alpha);  % tand gives the tangent of the element expressed in degrees.
B1_y = -h;
B2_x = B_x;
B2_y = B1_y;
Patch_x = ([B_x B1_x B2_x]); % use of Patch function for generating Triangle
Patch_y = ([B_y B1_y B2_y]);
b = 2*cosd(Alpha);       %Shift of y-axis
dis = B1_x/cosd(Alpha);     %Distance the mass slides
a = g*sind(Alpha);        %Acceleration in plane
tim = sqrt(2*dis/a);         %Duration of sliding
F = tim*50;       %frames per second  
ti = tim/F;         %time interval between frames
t_x(1) = 0;
for i=1:(round(F)+1)
    
    t_x(i+1) = t_x(i) + ti; %Moments in time the frames are shown
    
end
for k=1:length(t_x)
    
    dis_t(k) = (1/2)*a*t_x(k)^2;           %c distance covered over time
    
    z(1,k) = dis_t(k)*cosd(Alpha); %X-Axis                %calculation with the orthogonal plane (-1)*s_pk(k)*cosd(Alpha) + X_Ortho;
    z(2,k) = tand((-1)*Alpha)*z(1,k)+b; %Y-Axis           %s_pk(k)*sind(Alpha) + Y_Ortho;
    
end
% Animation for the rolling motion
q = 1;
Posx = 500;
Posy = 200;
width = 500;
height = 300;
fig = figure('Name', 'Rock Falling','NumberTitle','off','position', [Posx Posy width height], 'units', 'centimeters');
time = 0;
tic;     %to measure the elapsed time
while time < tim
    
    time = toc;
    
    clf;
    
    posDraw = interp1(t_x',z',time')';             %Interpolates Position of mass based on real time
    hold on;
    patch(Patch_x, Patch_y,[0.4660 0.6740 0.1880])                %Generates the Triangle wih colour
   
    fill(posDraw(1)+b+2*cos(0:0.01:2*pi), posDraw(2)+b+2*sin(0:0.01:2*pi), [0.8500 0.3250 0.0980])

    axis equal;
    axis off;
    
    filename = 'rock_simulation_AG.gif';
    frame = getframe(1);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      if i == 1
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
      else
          % overwrite then change to append
          imwrite(imind,cm,filename,'gif','WriteMode','append');
      end
end