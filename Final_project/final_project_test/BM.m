clc; clear; close all;
%% parameters
mu = 0.1; % drift coefficient
sigma = 0.3; % volatility
frame = 20;
T = 1; % 1 min
N = T * 60; % number of step
M = 1; % number of particle
dt = T/N;
radius = 1; % radius of single particle

x.origin = 0; y.origin = 0;
x.position = transpose(zeros(M, N));
y.position = transpose(zeros(M, N));


%% step
format long
rng default
step = exp((mu - power(sigma,2)/2)*dt + sigma * sqrt(dt) * randn([M N]));
step = transpose(step);

for j = 1:size(step, 2) % go through every ball
    for i = 2:size(step, 1) % every steps
        theta = 2*pi*rand;
        x.position(i,j) = x.position(i-1,j) + step(i,j) * cos(theta);
        y.position(i,j) = y.position(i-1,j) + step(i,j) * sin(theta);
    end
end

%% plot
% figure(1)
% hold on
% for j = size(y.position, 2)
%     plot(x.position(:,j), y.position(:,j))
% end
% hold off
% axis([-5 5 -5 5])
% set(gcf, 'Position', [1500 500 600 500])
% xlabel("x_{position}"); ylabel("y_{position}");
% box on; grid on