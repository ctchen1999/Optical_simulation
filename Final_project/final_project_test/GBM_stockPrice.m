% % Reference
% https://zh.wikipedia.org/zh-tw/%E7%BB%B4%E7%BA%B3%E8%BF%87%E7%A8%8B
% https://quantpy.com.au/stochastic-calculus/simulating-geometric-brownian-motion-gbm-in-python/
%%
clc; clear; close all;

%% Parameters
mu = 0.1; % drift coefficient
sigma = 0.3; % volatility
n = 10; % number of steps
T = 1; % Time in year
M = 10; % number of simulation
S0 = 100; % initial stock price

frame = 20;
%% Simulate GBM Paths
format short
rng default
dt = T/n;
St = exp((mu - power(sigma,2)/2)*dt + sigma * sqrt(dt) * randn([M n]));
St = transpose([ones([M 1]) St]);
St = S0 * cumprod(St);

time = linspace(0,T,n+1);
tt = zeros([M n+1]);
for i=1:size(tt,1)
    tt(i,:) = time;
end
tt = transpose(tt);

%% plot
plot(tt,St)
xlabel('Years(t)')
ylabel('Stock Price (St)')
[t,s] = title('Realization of Geometric Brownian Motiond','St = \mu・St・dt + \sigma・St・dWt');
set(t, 'FontSize', 14)
s.FontAngle = 'italic';
set(gcf, 'Position', [1000 600 600 500])
set(gca, 'FontSize', 14)