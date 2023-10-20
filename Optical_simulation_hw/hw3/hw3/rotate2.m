function [rock_position_x, rock_position_y] = rotate2(x, y)
    rock_position_x = [x(1)-0.5+1/sqrt(2), x(2)+0.5, x(3)+0.5-1/sqrt(2), x(4)-0.5];
    rock_position_y = [y(1)-0.5, y(2)-0.5+1/sqrt(2), y(3)+0.5, y(4)+0.5-1/sqrt(2)];
    rock_position_x = round(rock_position_x, 2);
    rock_position_y = round(rock_position_y, 2);
end