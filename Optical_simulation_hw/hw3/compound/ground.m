classdef ground<handle
    properties (SetAccess = private)
        slope,b
        gx,gy
    end
    
	methods
        function self = ground(slope,b,world)
            self.slope = slope;
            self.b = b;
            
            figure(1),
            self.gx=linspace(0,world.bxR,1000);
            self.gy=slope*self.gx.^2;
            plot(self.gx,self.gy,'k');
            axis([world.bxL, world.bxR, world.byB, world.byT]);
            axis manual;
        end
        
        function obj = draw_g(obj,world)
            figure(1),
            plot(obj.gx,obj.gy,'k');
            axis([world.bxL world.bxR world.byB world.byT]);
            axis equal;
            axis manual;
        end
	end
end