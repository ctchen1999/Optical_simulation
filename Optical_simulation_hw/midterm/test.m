x= -0.9:0.05:0.9;
y= 1./(1-x);
N = 1; %N: no. of terms
y1 = 0*y;
for i = 0:N
   y1= y1+(x.^i);
   e1= abs(y-y1);
  
end
N2 = 2;
y2=0*y;
for i = 0:N2
   y2 = y2+(x.^i);
   e2= abs(y-y2);
end
N3 = 10;
y3=0*y;
for i= 0:N3
   y3= y3+(x.^i);
   e3= abs(y-y3);
end
N4 = 100;
y4=0*y;
e4 = 0*0;
for i = 0:N4
    y4 = y4+(x.^i); 
    e4 = abs(y-y4);
end
hold on
plot(x,y,'*r')
plot(x,y1,'-b');
plot(x,y2,'^g');
plot(x,y3,'>k');
plot(x,y4,'--m');
hold off
figure
hold on
 grid on
plot(1:N+1,e1); %Matlab shows an error while doing this
plot(1:N2+1,e2,'-b');
plot(1:N3+1,e3,'^g');
plot(1:N4+1,e4,'pc');
hold off