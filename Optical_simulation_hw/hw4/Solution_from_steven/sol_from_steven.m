% This is the Hw4 code from 周昱廷(Steven), hope you guys can successfully complete Hw5-1.
% This code doesn't use any "for" loop, only one "while" loop is needed.
% And the algorithm is based on the "+" and ".*" of matrix.
% If you want to know how long it took to execute the program, 
% you can press the "Run and time" button instead of "Run".
% For people who are not really familiar with MATLAB, you can easily adjust 
% basic parameters to simulate different conditions.
%% Basic parameters
clc;clear;close all;
N=200;          %Recommended value: 100~500
angle=30;       %Recommended value: 10~120, over 120 degree should adjust code #29-31 (line) 
delta_V=0.01;   %Recommended value: 0.01~0.0001

%% initialize
%create boundary(N,Top,Bottom,Left,Right)
Space=boundary(N,30,10,20,5);

%% circle 0V
circle=ones(N);
r=N/10;
[m,n]=meshgrid(0:N-1);
% circle equation (x-x0)^2+(y-y0)^2=r^2
circle(((m-N/1.5).^2+(n-N/2).^2-r^2)<=r*5)=0;

%% triangle 100V
assert(angle>0);
triangle_0=ones(N);
[x,y]=meshgrid(0:N-1);
%triangle formed by three lines
% Adjust the line "x>=N/5" to "x>=N/2.5" can make the height of the
% triangle smaller.
triangle_0(((y+tand(angle/2)*(x+N*(tand(90-angle/2)-1)/2)+2)<=N) & (abs(y-tand(angle/2)*(x+N*(tand(90-angle/2)-1)/2)-N-1)<=N) & (x>=N/5))=0;
triangle=abs(triangle_0-1)*100;

%% other parameters
max_V=1;
a=zeros(1,N);
b=zeros(N+2,2);
d=zeros(2,N+2);
e=zeros(N,1);
i=0;

%% iteration
while max_V>=delta_V
    LastSpace=Space;
    %Fixed boundary, and calculate V inside
    NewSpace=([[a;Space;a],b]+[b,[a;Space;a]]+[[e,Space,e];d]+[d;[e,Space,e]])/4;
    Space(2:N-1,2:N-1)=NewSpace(3:N,3:N);
    %circle 0V
    Space=Space.*circle;
    %triangle 100V
    Space=Space.*triangle_0+triangle;
    %detect max_V
    max_V=max(abs(LastSpace-Space),[],'all');
 %fprintf('when %.4f < %f stop\n',max_V, delta_V)
 %% Uncomment this area to show the animation of voltage iteration
%     %But it will make computing really slow.
%     figure(1),
%     meshc(Space);
%     view([4 -2 2]);
%     axis([0,N,0,N,-100,100]);
%     pause(0.0001);
    %% Record the number of iterations
    i=i+1;
end

%% show the result
figure(1),
meshc(Space);
view([1 -2 1]);
axis([0,N,0,N,-100,100]);
xlabel('X (m)');  
ylabel('Y (m)');  
zlabel('Potential (V)');
%Equipotential line
figure(2), 
contour(Space,[0.1,linspace(0,100,11)],'ShowText','on');
hold on;

%% Uncomment this area to show E=-gradient(V)
[dx,dy]=gradient(Space,.1,1);
q=quiver(-dx,-dy,0,'k');
q.AutoScale='on';
q.AutoScaleFactor=50; %Scale of arrows
axis([0,N,0,N,-100,100]);

%% 
axis equal;
title('Equipotential Contour (V)');
xlabel('X (m)');  
ylabel('Y (m)'); 
fprintf('angle=%d, iteration=%d\n',angle,i);
hold off;

%% detail of boundary
function BD=boundary(N,Top,Bottom,Left,Right)
    BD=zeros(N,N);
    BD(1,:)=ones(1,N)*Top;      %Top
    BD(N,:)=ones(1,N)*Bottom; %Bottom
    BD(:,1)=ones(N,1)*Left;     %Left
    BD(:,N)=ones(N,1)*Right; %Right
    %Because four corners of the boundary will overlap, I take the Volt 
    %average of two adjacent edges.
    BD(1,1)=(Top+Left)/2;       %Top-Left
    BD(1,N)=(Top+Right)/2;      %Top-Right
    BD(N,1)=(Bottom+Left)/2;    %Bottom-Left
    BD(N,N)=(Bottom+Right)/2; %Bottom-Right
end