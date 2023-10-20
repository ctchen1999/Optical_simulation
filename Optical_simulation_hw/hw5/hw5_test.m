clc; clear;
%% Basic parameters
m = 9.109e-31; % mass of electron
q = 1.6e-19;   % charge of electron
v0 = 100; % initial velocity
r = 0.1;
row = 100; col = row;
field = zeros(row,col);
d = linspace(-0.5, 0.5, row);

F = m*v0^2/r;

for angle = linspace(0,2*pi,50)
    x = 0; y = 0;
    x_electron = x + r*cos(angle); 
    y_electron = y + r*sin(angle);
    dx = abs((F*cos(angle)) / q);
    dy = abs((F*sin(angle)) / q);
    if (rad2deg(angle) >= 0) && (rad2deg(angle) <= 90)
        field = field_setting(row, col, dx, 0, dy, 0);
        disp(1)
    elseif (rad2deg(angle) > 90) && (rad2deg(angle) <= 180)
        field = field_setting(row, col, dx, 0, 0, dy);
        disp(2)
    elseif (rad2deg(angle) > 180) && (rad2deg(angle) <= 270)
        field = field_setting(row, col, 0, dx, dy, 0);
        disp(3)
    elseif (rad2deg(angle) > 270) && (rad2deg(angle) <= 360)
        field = field_setting(row, col, 0, dx, 0, dy);
        disp(4)
    disp(1)
    for it = 1:10000
        for i = size(field,1)-1:-1:2
            for j = size(field,2)-1:-1:2
                field(i,j) = (field(i+1,j)+field(i-1,j)+field(i,j+1)+field(i,j-1))/4;
            end
        end
    end
    

%     disp(field)
%     hold on
%     plot(x_electron, y_electron, 'MarkerSize', 12)
    [X,Y] = meshgrid(d,d);
    [DX,DY] = gradient(field);
    quiver(X, Y, DX, DY, 100);
    axis([-0.2 0.2 -0.2 0.2])
    drawnow
    end
end
%%
function f = field_setting(row, col, top, bottom, left, right)
f = zeros([row, col]);
f(1,:) = top;    % upper boundary
f(end, :) = bottom; % lower boundary
f(:, 1) = left;   % left boundary
f(:, end) = right;  % right boundary

f(1,1) = (top+left)/2;
f(1,col) = (top+right)/2;
f(row,1) = (left+bottom)/2;
f(row,col) = (right+bottom)/2;
end


