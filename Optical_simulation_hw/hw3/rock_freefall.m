clc; clear; close all;
%%

%% mountain parameter
rock_center_x = []; 
rock_center_y = [];
mountain_x = [ 20 15 10 5 0 ];
mountain_y = [ 20 15 15 5 0 ];
mountain_xi = 20:-0.01:-0;
mountain_yi = interp1(mountain_x, mountain_y, mountain_xi, 'spline');
m = diff(mountain_yi)./diff(mountain_xi);
rock_center_x(1) = 20;
rock_center_y(1) = 20;

%% Newton motion law

v = []; v(1) = 0;
g = 9.8;
v_initial = 0;
frame = 10;

for i = 2:length(mountain_xi)
    angle = atan(m(i-1)); % angle is in radians
    % v(i) = v(i-1) + a・t
    if (m(i-1)<0)
        v(i) = v(i-1) - g*sin(angle)*(1/frame); % if rock goes up, velocity decrease
    else
        v(i) = v(i-1) + g*sin(angle)*(1/frame); 
    end
    % v^2(i) = v^2(i-1) + 2・a・s
    delta_distance = ( v(i)^2 - v(i-1)^2 ) / (2*g/sin(angle));
    delta_x = delta_distance * cos(angle);
    rock_center_x(i) = rock_center_x(i-1) - delta_x;
    rock_center_x(i) = round(rock_center_x(i), 2);

end

count = 0; % at which point of rock_position_x, x<0 (not reasonable)
for i = 1:length(rock_center_x)
    if rock_center_x(i) < 0
        break
    end
    count = count + 1;
end

for i = 1:count
    for j = 1:size(mountain_xi,2)
        if rock_center_x(i) == mountain_xi(j)
            rock_center_y = [rock_center_y mountain_yi(j)];
            continue
        end
    end
end
rock_center_y = [rock_center_y(rock_center_y>0) 0];

x = [];
for i = 1:length(rock_center_y)
    x = [x rock_center_x(i)];
end
rock_center_x = x;


mountain_xi = [mountain_xi 20 20];
mountain_yi = [mountain_yi  0 20];
for i = 1:length(rock_center_y)
    hold on
    % plot rock
    
    rock_x = [rock_center_x(i)-0.9 rock_center_x(i)-0.9 rock_center_x(i)+0.1 rock_center_x(i)+0.1]; % current rock x position
    rock_y = [rock_center_y(i)+1.1 rock_center_y(i)+0.1 rock_center_y(i)+0.1 rock_center_y(i)+1.1]; % current rock y position

    % rotate
    switch rem(i,4)
        case 1
            [rock_x, rock_y] = rotate(rock_x, rock_y);
        case 2
            [rock_x, rock_y] = rotate(rock_x, rock_y);
            [rock_x, rock_y] = rotate2(rock_x, rock_y);

        case 3
            [rock_x, rock_y] = rotate(rock_x, rock_y);
            [rock_x, rock_y] = rotate2(rock_x, rock_y);
            rock_x = circshift(rock_x,1);
            rock_y = circshift(rock_y,1);
            [rock_x, rock_y] = rotate(rock_x, rock_y);
        case 0
            [rock_x, rock_y] = rotate(rock_x, rock_y);
            [rock_x, rock_y] = rotate2(rock_x, rock_y);
            rock_x = circshift(rock_x,1);
            rock_y = circshift(rock_y,1);
            [rock_x, rock_y] = rotate(rock_x, rock_y);
            [rock_x, rock_y] = rotate2(rock_x, rock_y);
        otherwise
            break
    end
    
    %% rock edge detection

    m_rock = diff(rock_center_y)./diff(rock_center_x);
    if i ~= length(rock_center_y)
        if m_rock(i) < 0
            rock_y = rock_y + 0.3;
        end
    end
    
    
    %% plot mountain    
    plot(mountain_xi, mountain_yi,'LineWidth',5,'Color',[0.7764 0.9215 0.7725]);
    fill(mountain_xi, mountain_yi, [0.7764, 0.9215, 0.7725]);
    
    xlim([-10 20]);
    ylim([0 22]);
    drawnow
    %% plot road
    x_road = [-10  -10  10  1];
    y_road = [  0   22  22  0];
    fill(x_road, y_road, [0.7137 0.7686 0.8117]);
    %  zebra crossing
    l1 = line([-6.5 -5], [0 5.28]);
    set(l1, 'Color', [1 1 1], 'LineWidth', 8)
    l2 = line([-3.5 -2], [10 15.28]);
    set(l2, 'Color', [1 1 1], 'LineWidth', 8)
    l3 = line([-0.75 -0.2], [20 22]);
    set(l3, 'Color', [1 1 1], 'LineWidth', 8)
    l4 = line([-10 -8.5], [16.5 22]);
    % 雙黃線
    set(l4, 'Color', [1 0.8706 0], 'LineWidth', 4)
    l5 = line([-10 -7.7], [14 22]);
    set(l5, 'Color', [1 0.8706 0], 'LineWidth', 4)
    % 把圖邊緣補齊
    l6 = line([10 20], [22 22]);
    set(l6, 'Color', [0 0 0]);
    l7 = line([20 20], [22 20]);
    set(l7, 'Color', [0 0 0]);
    drawnow
    %% plot rock
    fill(rock_x, rock_y, [0.4392 0.3098 0.3098]);
    % when last rock, break
    if i==length(rock_center_y)
        l = line([rock_x(2) rock_x(4)], [rock_y(2) rock_y(4)]);
        set(l, 'Color', [1 1 1], 'LineWidth', 2)
    end
    axis off
    hold off
    %% GIF
%     filename = 'rock_simulation.gif';
%     frame = getframe(1);
%       im = frame2im(frame);
%       [imind,cm] = rgb2ind(im,256);
%       if i == 1
%           imwrite(imind,cm,filename,'gif', 'Loopcount',inf);
%       else
%           % overwrite then change to append
%           imwrite(imind,cm,filename,'gif','WriteMode','append');
%       end
end
