%% problem 
% 1. how do you judge simulation
% 2. (1) change 
%    (2) what effects that will affect the result?

%% Laplace eq. lecture source: 
% 1. https://www.youtube.com/watch?v=-D4GDdxJrpg
% 2. https://www.youtube.com/watch?v=5-QAgZ81gg0

%% test
clc; clear; close all;
field = ones(100,100);
% field(:, 1) = 20; % left boundary
% field(:, end) = 5; % right boundary
field(1,:) = 0; % upper boundary
field(end, :) = 10; % lower boundary
disp(field);

for time = 1:100000
    for i = 2:size(field,1)-1
        for j = 2:size(field,2)-1
            field(i,j) = (field(i+1,j) + field(i-1,j) + field(i,j+1) + field(i,j-1)) / 4;
        end
    end
end
disp(field)

x = 1:size(field,2); y = 1:size(field,1); z = field;
[x, y] = meshgrid(x,y);
[px, py] = gradient(z);

contour(x,y,z)
% quiver(x,y,px,py,6)
axis([1 size(field,2) 1 size(field,1)])