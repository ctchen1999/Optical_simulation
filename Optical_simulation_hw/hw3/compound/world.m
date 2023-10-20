classdef world<handle
    properties (SetAccess = private)
        bxL,bxR,byB,byT,g,dt,frame
    end
    
	methods
        function self = world(bxL,bxR,byB,byT,g,dt,frame)
            self.bxL = bxL;
            self.bxR = bxR;
            self.byB = byB;
            self.byT = byT;   
            self.g = g;
            self.dt = dt;
            self.frame = frame;
            
            figure(1),
            axis([bxL bxR byB byT]);
            axis manual;
        end
        function obj=bound(obj)
            figure(1),
            axis([obj.bxL obj.bxR obj.byB obj.byT]);
        end
	end
end