classdef Electirc_field

    properties
        field, row, col, angle, triangle_1, triangle_2, triangle_3,r, center, azimuth, elevation
    end

    methods
        function self = Electirc_field(row, col, angle, azimuth, elevation)
            % field basic setting
            self.row = row; 
            self.col = col;
            self.field = ones(row,col);
            self.angle = angle;
            self.field(:, 1) = 20;   % left boundary
            self.field(:, end) = 5;  % right boundary
            self.field(1,:) = 10;    % upper boundary
            self.field(end, :) = 30; % lower boundary  

            % triangle field parameters setting
            self.triangle_1 = [size(self.field,2)*0.5 size(self.field,1)*0.5];
            self.triangle_2 = [self.triangle_1(1)+round((self.triangle_1(2)-size(self.field,1)*0.2)*tan(deg2rad(self.angle/2))) size(self.field,2)*0.2];
            self.triangle_3 = [self.triangle_1(1)+round((self.triangle_1(2)-size(self.field,1)*0.2)*tan(deg2rad(-self.angle/2))) size(self.field,2)*0.2];
            self.field(self.triangle_1(1), self.triangle_1(2)) = 100;
            self.field(self.triangle_2(1), self.triangle_2(2)) = 100;
            self.field(self.triangle_3(1), self.triangle_3(2)) = 100;

            % circle field parameters setting
            self.r = size(self.field,2)*0.1;
            self.center = [size(self.field,2)*0.5 size(self.field,1)*0.75];

            % view
            self.azimuth = azimuth;
            self.elevation = elevation;
        end


        function field_calculation(obj)
            for time = 1:1000
                
                % circle field generate
                for i = 0:0.01:2*pi
                    x_pos = round(obj.center(2) + obj.r*cos(i));
                    for j = round(obj.center(1) + obj.r*sin(i)):1:round(obj.center(1) + obj.r*sin(-i))
                        obj.field(j, x_pos) = 0;
                    end
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
%                     disp(obj.r)
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                for i = 2:size(obj.field,1)-1
                    for j = 2:size(obj.field,2)-1
                        obj.field(i,j) = (obj.field(i+1,j) + obj.field(i-1,j) + obj.field(i,j+1) + obj.field(i,j-1)) / 4;
                    end
                end
               
              
                x = linspace(1,10,size(obj.field,1)); y = linspace(1,10,size(obj.field,2));
                [x,y] = meshgrid(x,y);
%                 contour(x,y,obj.field,'ShowText','on')
                meshc(x,y,obj.field)
                set(gcf, 'Position', [1200 500 600 500])
                colorbar
                zlabel('Voltage'); axis([1 10 1 10 0 100])
                view(obj.azimuth, obj.elevation) % 方位角、俯視
                drawnow

            end
        end
    end
end