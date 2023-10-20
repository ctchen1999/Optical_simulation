clc; clear; close all;
format long
%%
h = 0.0001; x = 0:h:1;
y = sqrt(1-x.^2);
% plot(x,y)

%% normal ways to calculate
area.ideal = pi;
fprintf("Ideal value is %d\n\n", area.ideal)

% 1: midpoint method
midPointsX = (x(1:end-1) + x(2:end)) ./ 2;
midPointsY = sqrt(1 - midPointsX.^2);
area.midpoint = sum(midPointsY * h);
error.midpoint = abs(area.ideal - 4*area.midpoint) / area.ideal;
fprintf("For midpoint-method\narea is %d\nerror is %d\n\n", area.midpoint, error.midpoint)

% 2: trapezoid
area.trapezoid = sum(y(1:end-1) + y(2:end)) * 0.5 * h;
error.trapezoid = abs(area.ideal - 4*area.trapezoid) / area.ideal;
fprintf("For trapezoid-method\narea is %d\nerror is %d\n\n", area.trapezoid, error.trapezoid)

% 3: Simpson-method
area.simpson = sum((y(1:2:end-2) + 4*y(2:2:end-1) + y(3:2:end))/3) * h;
error.simpson = abs(area.ideal - 4*area.simpson) / area.ideal;
fprintf("For Simpson-method\narea is %d\nerror is %d\n\n", area.simpson, error.simpson)

% 4: Area method
% the probability that the point is inside the quarter circle is equal to the ratio 
% of the area of the quarter circle divided by the area of the unit square.
rng default

inside = 0; outside = 0;
randomNumberX = rand(1,1000000);
randomNumberY = rand(1,1000000);
for i = 1:size(randomNumberX, 2)
    if sqrt(randomNumberX(i)*randomNumberX(i)+randomNumberY(i)*randomNumberY(i)) < 1
        inside = inside + 1;
    else 
        outside = outside + 1;
    end
end
area.MC = inside / (inside + outside);
error.MC = abs(area.ideal - 4*area.MC) / area.ideal;
fprintf("For Monte carlo\narea is %d\nerror is %d\n\n", area.MC, error.MC)

% 5: monte carlo

