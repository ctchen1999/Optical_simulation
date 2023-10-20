clear; close all;
%% basic parameters
mu = 0.133246168;
sigma = 0.230779692;
year = 5; % 預測後n年
numberOfSimulation = 50;
numberOfSteps = 10000000;
initialPrice = 3934.38;

%% show figure results
W_BM = BMStockPrice(mu, sigma, year, numberOfSimulation, numberOfSteps, initialPrice);
W_MC = MCStockPrice(mu, sigma, year, numberOfSimulation, numberOfSteps, initialPrice);

%% comparison

% simple moving average (SMA)
window = 10000;
BM_movingAverage = zeros([numberOfSteps/window numberOfSimulation]);
MC_movingAverage = zeros([numberOfSteps/window numberOfSimulation]);
for j=1:size(W_BM, 2)
    count = 1;
    for i=1:window:size(W_BM, 1)
        BM_movingAverage(count,j) = sum(W_BM(i:i+window-1, j)) / window;
        MC_movingAverage(count,j) = sum(W_MC(i:i+window-1, j)) / window;
        count = count + 1;
    end
end

figure
set(gcf, "Position", [0 0 1000 1000])
subplot(2,2,1)
plot(linspace(0,year,numberOfSteps/window), BM_movingAverage)
title("SMA of brownian motion")
xlabel("Year(t)"); ylabel("Stock price(S_{t})");
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
set(gca, 'FontSize', 12); xlim([0 year])
subplot(2,2,2)
plot(linspace(0,year,numberOfSteps/window), MC_movingAverage)
title("SMA of Monte Carlo")
xlabel("Year(t)"); ylabel("Stock price(S_{t})");
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
set(gca, 'FontSize', 12); xlim([0 year])
subplot(2,2,3)
plot(linspace(0,year,numberOfSteps), mean(W_BM,2))
title("Brownian motion average stock price");
xlabel("Year(t)"); ylabel("Stock price(S_{t})");
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
set(gca, 'FontSize', 12); xlim([0 year])
subplot(2,2,4)
plot(linspace(0,year,numberOfSteps), mean(W_MC,2))
title("Monte Carlo average stock price");
xlabel("Year(t)"); ylabel("Stock price(S_{t})");
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
set(gca, 'FontSize', 12); xlim([0 year])

%% analysis

% 1. increase？ n年後的漲幅
BM_average = mean(W_BM,2);
fprintf("Increase %d for Brownian motion\n", round((BM_average(end)-BM_average(1))/BM_average(1),2));
MC_average = mean(W_MC,2);
fprintf("Increase %d for Monte Carlo\n", (MC_average(end)-MC_average(1))/MC_average(1))

% max-min？ 曲線最大與最小的差別？
fprintf("MAX-MIN for Brownian motion %d\n", max(BM_average)-min(BM_average));
fprintf("MAX-MIN for Monte Carlo %d\n", max(MC_average) - min(MC_average));
