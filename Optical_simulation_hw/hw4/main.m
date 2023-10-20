clc; clear; close all;
%% parameter setting
field = zeros(50,50); % 100x100 field matrix
field(:, 1) = 20; % left boundary
field(:, end) = 5; % right boundary
field(1,:) = 10; % upper boundary
field(end, :) = 30; % lower boundary

%%% triangle paremeters
triangle_1 = [size(field,2)*0.5 size(field,1)*0.5];
triangle_2 = [size(field,2)*0.5 size(field,1)*0.2];
angle = deg2rad(30);
triangle_3 = [triangle_2(1)-round((triangle_1(2)-triangle_2(2))*tan(angle)) triangle_2(2)];
field(triangle_1(1), triangle_1(2)) = 100;
field(triangle_2(1), triangle_2(2)) = 100;
field(triangle_3(1), triangle_3(2)) = 100;

%%% circle parameters
r = 10;
center = [size(field,2)*0.5 size(field,1)*0.75];

%%
for time = 1:500
    %%%%%%%%%
    x_pos = zeros(1,length(0:0.1:2*pi)); y_pos = zeros(1,length(0:0.1:2*pi));
    count = 1;
    for i = 0:0.1:2*pi
        x_pos(count) = round(center(2) + r*cos(i));
        y_pos(count) = round(center(1) - r*sin(i));
        field(y_pos(count), x_pos(count)) = 0;
        if i <= pi
            for j = center(1):-1:y_pos(count)
                field(j, x_pos(count)) = 0;
            end
        else
            for j = center(1):1:y_pos(count)
                field(j, x_pos(count)) = 0;
            end
        end

        count = count + 1;
    end

    x_pos = zeros(1, triangle_1(2)-triangle_2(2)); y_pos = zeros(1,triangle_1(2)-triangle_2(2));
    for i = 0:(triangle_1(2)-triangle_2(2))-1
        x_pos(i+1) = triangle_2(2) + i;
        h = round((triangle_1(2)-triangle_2(2)-i) * tan(angle));
        y_pos(i+1) = triangle_2(1) - h;
        field(y_pos(i+1), x_pos(i+1)) = 100;
        for j = triangle_2(1):-1:y_pos(i+1)
            field(j,triangle_2(2)+i) = 100;
        end
    end
    %%%%%%%%%
    if time == 1
        disp(field)
    end
    %%%%%%%%%%

    for i = 2:size(field,1)-1
        for j = 2:size(field,2)-1
            field(i,j) = (field(i+1,j) + field(i-1,j) + field(i,j+1) + field(i,j-1)) / 4;
        end
    end
    x = linspace(1,10,size(field,1)); y = linspace(1,10,size(field,2));
    [x,y] = meshgrid(x,y);
    contour3(x,y,field,40)
    colorbar
    zlabel('Voltage'); axis([1 10 1 10 -100 100])
%     contour(x,y,field-100,40);
    view(30,45) % 方位角、俯視
    % view(0,90) % from top

    drawnow
end