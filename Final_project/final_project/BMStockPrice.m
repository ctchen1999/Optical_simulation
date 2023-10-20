% % Reference
% https://zh.wikipedia.org/zh-tw/%E7%BB%B4%E7%BA%B3%E8%BF%87%E7%A8%8B
% https://quantpy.com.au/stochastic-calculus/simulating-geometric-brownian-motion-gbm-in-python/
% https://www.investopedia.com/articles/07/montecarlo.asp

% This function will generate a prediction figure by Brownian Motion(BM)
function St = BMStockPrice(mu, sigma, year, numberOfSimulation, numberOfSteps,initialPrice)

%% Simulate BM Paths
format long
% rng default
dt = year/numberOfSteps;
% drift. shock 是BM 兩個常數
drift = mu - power(sigma,2)/2; % drift is also known as the expected daily return
shock = sigma * randn([numberOfSimulation numberOfSteps]);
St = drift * dt + shock * sqrt(dt);
St(:,1) = initialPrice;
% St(:,1) = 1;
St = transpose(St);
St = St + 1;
St = cumprod(St); % St: stock price of the whole process

%% time setting
time = linspace(0,year,numberOfSteps);
tt = zeros([numberOfSimulation numberOfSteps]);
for i=1:size(tt,1)
    tt(i,:) = time;
end
tt = transpose(tt);

%% plot the result

figure
plot(tt,St)
xlabel('Years(t)')
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
ylabel('Stock Price (S_{t})')
[t,~] = title('Realization of Brownian Motion','St = \mu・St・dt + \sigma・St・dWt');
grid on
set(t, 'FontSize', 14)
set(gcf, 'Position', [1000 0 600 500])
set(gca, 'FontSize', 14)
end