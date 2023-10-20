%% Reference
% https://www.investopedia.com/terms/m/montecarlosimulation.asp

% This function will generate a prediction figure by Monte Carlo(MC)
function W = MCStockPrice(mu, sigma, year, numberOfSimulation, numberOfSteps, initialPrice)

%% Simulate MC paths
format long
% rng default
dt = year/numberOfSteps;
drift = mu - power(sigma,2)/2; % drift is also known as the expected daily return
shock = sigma * randn([numberOfSimulation numberOfSteps]) * sqrt(dt);
W = zeros([numberOfSimulation numberOfSteps]); % W represent stock price change
dW = exp(drift*dt + shock);
W(:, 1) = initialPrice;

for i = 1:size(W,1)
    for j = 2:numberOfSteps
        W(i,j) = W(i,j-1)* dW(i,j);
    end
end
W = transpose(W); % 一條線, 同一column

%% plot the result

figure
plot(dt:dt:year, W);
grid on
t = title('Discreted Standard Monte carlo sample path');
xticks(0:year); xticklabels(["2022", "2023", "2024", "2025", "2026", "2027"]);
xlabel('Years(t)')
ylabel('W(t)')
set(t, 'FontSize', 14)
set(gcf, 'Position', [1000 600 600 500])
set(gca, 'FontSize', 14)
end