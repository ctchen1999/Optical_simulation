clc; clear; close all;
% x = linspace(-2, 2, 25);	% 在 x 軸 [-2,2] 之間取 25 點  
% y = linspace(-2, 2, 25);	% 在 y 軸 [-2,2] 之間取 25 點  
% [xx, yy] = meshgrid(x, y);	% xx 和 yy 都是 25×25 的矩陣  
% zz = yy.^2;	% 計算函數值，zz 也是 25×25 的矩陣
% mesh(xx, yy, zz);		% 畫出立體網狀圖 

[x, y, z] = sphere;
surf([x,y,z]);
axis equal