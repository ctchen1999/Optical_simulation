w1=world(-200,200,0,600,-25.8,0.1,170);
g1=ground(0.015, 0.9, w1);
c1=compound(150, 600, 0, 0, 40, [20,20],[30,10],[20,-20],[0,-30],[-20,-20],[-30,0],[-20,20]);
%c2=compound(100, 600, 10, 20, 40, [20,20],[0,-30],[-20,20]);
for i=0:w1.frame
    draw_g(g1,w1);
    move(c1,g1,w1);
    %move(c2,g1,w1);
end