classdef Electirc_field

    properties
        field, row, col, angle, triangle_1, triangle_2, triangle_3,r, center, azimuth, elevation
    end

    methods
        function obj = Electirc_field(row, col, angle, azimuth, elevation)
            % field basic setting
            obj.row = row;
            obj.col = col;
            obj.field = ones(row,col);
            obj.angle = angle;
            obj.field(:, 1) = 20;   % left boundary
            obj.field(:, end) = 5;  % right boundary
            obj.field(1,:) = 10;    % upper boundary
            obj.field(end, :) = 30; % lower boundary  

            % triangle field parameters setting
            obj.triangle_1 = [size(obj.field,2)*0.5 size(obj.field,1)*0.5];
            obj.triangle_2 = [obj.triangle_1(1)+round((obj.triangle_1(2)-size(obj.field,1)*0.2)*tan(deg2rad(obj.angle/2))) size(obj.field,2)*0.2];
            obj.triangle_3 = [obj.triangle_1(1)+round((obj.triangle_1(2)-size(obj.field,1)*0.2)*tan(deg2rad(-obj.angle/2))) size(obj.field,2)*0.2];
            obj.field(obj.triangle_1(1), obj.triangle_1(2)) = 100;
            obj.field(obj.triangle_2(1), obj.triangle_2(2)) = 100;
            obj.field(obj.triangle_3(1), obj.triangle_3(2)) = 100;

            % circle field parameters setting
            obj.r = obj.field(2)*0.1;
            obj.center = [size(obj.field,2)*0.5 size(obj.field,1)*0.75];

            % view
            obj.azimuth = azimuth;
            obj.elevation = elevation;
        end


        function field_calculation(obj)
            for time = 1:5000
                
                % field boundary setting
                obj.field(:, 1) = 20;   % left boundary
                obj.field(:, end) = 5;  % right boundary
                obj.field(1,:) = 10;    % upper boundary
                obj.field(end, :) = 30; % lower boundary

                % circle field generate
                x_pos = zeros(1,length(0:0.1:2*pi)); y_pos = zeros(1,length(0:0.1:2*pi));
                count = 1;
                for i = 0:0.1:2*pi
                    x_pos(count) = round(obj.center(2) + obj.r*cos(i));
                    y_pos(count) = round(obj.center(1) - obj.r*sin(i));
                    obj.field(y_pos(count), x_pos(count)) = 0;
                    if i <= pi
                        for j = obj.center(1):-1:y_pos(count)
                            obj.field(j, x_pos(count)) = 0;
                        end
                    else
                        for j = obj.center(1):1:y_pos(count)
                            obj.field(j, x_pos(count)) = 0;
                        end
                    end

                    count = count + 1;
                end

                %triangle field generate         
                for j = obj.triangle_1(2):-1:obj.triangle_2(2)
                    for i = obj.triangle_1(2)+round((obj.triangle_1(1)-j)*tan(deg2rad(-obj.angle/2))):1:obj.triangle_1(2)+round((obj.triangle_1(1)-j)*tan(deg2rad(obj.angle/2)))
                        obj.field(i,j) = 100;
                    end
                    
                end
                %%%%%%%%%% check point %%%%%%%%%%
                if time == 1
                    disp(obj.field)
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                for i = 2:size(obj.field,1)-1
                    for j = 2:size(obj.field,2)-1
                        obj.field(i,j) = (obj.field(i+1,j) + obj.field(i-1,j) + obj.field(i,j+1) + obj.field(i,j-1)) / 4;
                    end
                end
                
                x = linspace(1,10,size(obj.field,1)); y = linspace(1,10,size(obj.field,2));
                [x,y] = meshgrid(x,y);
                contour3(x,y,obj.field,40)
                set(gcf, 'PaperSize', [20 20])
                colorbar
                zlabel('Voltage'); axis([1 10 1 10 0 100])
                view(obj.azimuth, obj.elevation) % 方位角、俯視
                drawnow

            end
        end
    end
end