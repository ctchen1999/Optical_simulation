clc; clear; close all;
%% Geometric solution
%% Basic 
t = linspace(0,2*pi,1001);
radius = 2;
C = [0, 0]; % center of circle
x_circle = radius * cos(t) + C(1);
y_circle = radius * sin(t) + C(2);

O = [-5 -5]; % Origin
direction = [1 1]; % direction of incident ray

%% 
D = normalize(direction, 'norm');
L = C - O;
tca = dot(L,D);
L = norm(L);
d = sqrt(L^2 - tca.^2);
thc = sqrt(radius^2 - d^2);
if (tca < 0) || (norm(d) > radius)
    condition = false;
    disp("outside the circle")
else
    disp("Pass through the circle")
    t0 = tca - thc;
    t1 = tca + thc;
    P1_geometric = O + D*t0 % First intersected point coordinate
    P2_geometric = O + D*t1 % Second intersected point coordinate
    P_1x = .1 * cos(t) + P1_geometric(1);
    P_1y = .1 * sin(t) + P1_geometric(2);
    P_2x = .1 * cos(t) + P2_geometric(1);
    P_2y = .1 * sin(t) + P2_geometric(2);
    figure
    hold on
    plot(P_1y(1), P_1y(2), 'Color', 'r')
    patch(x_circle,y_circle,[0 0 0])
    patch(P_1x, P_1y, [1 0 0])
    patch(P_2x, P_2y, [1 0 0])
    plot([O(1) P_2x], [O(2) P_2y])
    hold off
    axis equal
    xlim([-5 5]); ylim([-5 5]); box on
    set(gcf, 'Position', [1500 500 600 500])
end

