classdef ground3D<handle
    properties (SetAccess = private)
        left,right,slope,b
    end
    
	methods
        function self = ground3D(left,right,slope)
            self.left=left;
            self.right=right;
            self.slope = slope;
            
            figure(1),
            x=linspace(100,-100);
            y=linspace(left,right);
            [xx,yy]=meshgrid(x,y);
            zz=slope*yy.^2;
            mesh(xx,yy,zz);
            axis equal;
            %顯示角度
            [caz,cel] = view;
            v = [-5 -2 5];
            [caz,cel] = view(v);
        end
        
        function obj = draw_g(obj)
            figure(1),
            x=linspace(200,-200);
            y=linspace(obj.left,obj.right);
            [xx,yy]=meshgrid(x,y);
            zz=obj.slope*yy.^2;
            mesh(xx,yy,zz);
            axis equal;
            axis([-200 200 -400 400 -200 800]);
            
            %顯示角度
            [caz,cel] = view;
            v = [1 -2 5];
            [caz,cel] = view(v);
        end
	end
end