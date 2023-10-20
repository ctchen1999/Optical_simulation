% conductor 只有一點
clc; clear; close all;
%%
field = ones(100,100); % 100x100 field matrix
field(:, 1) = 0; % left boundary
field(:, end) = 0.01; % right boundary
field(1,:) = 0.01; % upper boundary
field(end, :) = 0; % lower boundary

% conductor_x1 = size(field,2)*0.5; conductor_y1 = size(field,1)*0.75;
% field(conductor_x1, conductor_y1) = 100; % 點導電

for time = 1:10000
    for i = 2:size(field,1)-1
        for j = 2:size(field,2)-1
            field(i,j) = (field(i+1,j) + field(i-1,j) + field(i,j+1) + field(i,j-1)) / 4;
        end
    end
    
%     contour(x,y,field,100)
%     colorbar
end
x = linspace(0,1,size(field,1)); y = linspace(0,1,size(field,2));
[x,y] = meshgrid(x,y);
[px, py] = gradient(field);
q = quiver(x, y, -px, -py);
axis([0.4 0.6 0.4 0.6])
% q.AutoScale='on';
q.AutoScaleFactor=50; %Scale of arrows
% disp(field)
