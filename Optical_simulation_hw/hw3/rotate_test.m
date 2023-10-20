clc; clear; close all;



for i = 1:4
    rock_x = [-1     -1    0    0];
    rock_y = [1.25 0.25 0.25 1.25];
    switch rem(i,4)
        case 1
            [rock_x, rock_y] = rotate(rock_x, rock_y);
        case 2
            [rock_x, rock_y] = rotate(rock_x, rock_y);
            [rock_x, rock_y] = rotate2(rock_x, rock_y);
            rock_x = circshift(rock_x,1);
            rock_y = circshift(rock_y,1);
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
    disp([rock_x; rock_y]);
    figure, fill(rock_x, rock_y, 'k')
    axis equal
end