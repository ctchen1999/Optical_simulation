clc;

% x1 = [20 15 10 5 0];
% y1 = [20 15 15 5 0];
% xi = 20:-0.01:0;
% yi = interp1(x1,y1,xi,'spline');
% xi = [xi 20 20];
% yi = [yi 0 20];
% plot(xi,yi,"Color",'k');
% fill(xi,yi,[0 1 0])

xlim([-10 20]);
ylim([0 22]);
x_road = [-10 -2.5  0 -5];
y_road = [  0   22 22  0];
fill(x_road, y_road, [0.7137 0.7686 0.8117]);
l1 = line([-7.5 -6], [0 5.28]);
set(l1, 'Color', [1 1 1], 'LineWidth', 8)
l2 = line([-4.5 -3], [10 15.28]);
set(l2, 'Color', [1 1 1], 'LineWidth', 8)
l3 = line([-1.75 -1.2], [20 22]);
set(l3, 'Color', [1 1 1], 'LineWidth', 8)
