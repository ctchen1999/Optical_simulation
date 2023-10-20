%% Reference
% https://medium.com/analytics-vidhya/monte-carlo-simulations-for-predicting-stock-prices-python-a64f53585662

%%
clc; clear; close all;
%%
randn(100);
T = 1; N = 100; dt = T/N;
dW(1) = sqrt(dt) * randn;
W(1) = dW(1);
for j = 2:N
    dW(j) = sqrt(dt) * randn;
    W(j) = W(j-1) + dW(j);
end

plot([0:dt:T], [0 W], 'r-');
grid on
title('Discreted Standard Brownian Motion sample path')
ylabel('W(t)')