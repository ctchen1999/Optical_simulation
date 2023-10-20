 classdef ball3D<handle
    properties
        %(z,x,y)
        cx,cy,cz,vx,vy,I,pointX,pointY
    end
    properties (SetAccess = private)
        id
    end
    
	methods
        function self = ball3D(cz,ox,oy,vx,vy,I,varargin)
            persistent id_
            if (isempty(id_)); id_ = 0; end
            self.id = id_;
            self.cz=cz;
            self.vx = vx;
            self.vy = vy;
            self.I = I;
            for i=1:numel(varargin)
                self.pointX(i)=varargin{i}(1);
                self.pointY(i)=varargin{i}(2);
            end
            mx=mean(self.pointX);
            my=mean(self.pointY);
            %oc=o'c+oo'
            self.cx=mx+ox;
            self.cy=my+oy;
            %ca=o'a-o'c
            self.pointX=self.pointX-mx;
            self.pointY=self.pointY-my;
            rockx=zeros(1,numel(self.pointX))+cz;
            fprintf('rockx:%d\n',numel(rockx));
            fprintf('self.pointX:%d',numel(self.pointX));
            figure(1),
            patch([-20,rockx,20],[self.cx,self.cx+self.pointX,self.cx],[self.cy,self.cy+self.pointY,self.cy],'k');

            id_=id_+1;
        end
      
        function obj=move(obj,gr,w)
            fcx=obj.cx;
            fcy=obj.cy;
            fvx=obj.vx;
            fvy=obj.vy;
            fpointX=obj.pointX;
            fpointY=obj.pointY;
            fI=obj.I;
            slope=gr.slope;
            dt=w.dt;
            g=w.g;
            drop=true;  %下墜或旋轉
            n=numel(fpointX);   %有n個點
            stop=false;
            pivot_p=zeros(3,2); %有哪兩個點可能為支點
            %找支點
            for j=1:n
                fprintf('j=%d\n',j);
                if slope*(fcx+fpointX(j))^2-(fcy+fpointY(j))>=0 || fcy+fpointY(j)<=0
                    pivot_p(1,2)=pivot_p(1,1);
                    pivot_p(2,2)=pivot_p(2,1);
                    pivot_p(3,2)=pivot_p(3,1);
                    pivot_p(1,1)=j;
                    pivot_p(2,1)=fpointX(j);
                    pivot_p(3,1)=fpointY(j);
                    drop=false; %有支點則為旋轉
                end
            end
            %判斷要以哪個支點旋轉，或停止
            if pivot_p(1,2)~=0
                if pivot_p(3,1)>pivot_p(3,2)
                    i=pivot_p(1,2);
                elseif pivot_p(3,1)<pivot_p(3,2)
                    i=pivot_p(1,1);
                else
                    drop=true;
                    stop=true;
                end
            else
                i=pivot_p(1,1);
            end
            
            %執行下墜、旋轉或停止
            if drop
                if ~stop
                    fprintf('drop\n');
                    %向下掉
                    fvy=fvy+g*dt;
                    fcy=fcy+fvy*dt;
                    fcx=fcx+fvx*dt;
                end
            else
                fvy=fvy+g*dt;
                fprintf('i=%d\n',i);
                fprintf('p=(%.2f,%.2f), c=(%.2f,%.2f)\n',fcx+fpointX(i),fcy+fpointY(i),-fpointX(i),-fpointY(i));
                fprintf('fpointX(i)=%d, fpointY(i)=%d\n',fpointX(i),fpointY(i));
                %支點座標
                cpX=fpointX(i);
                cpY=fpointY(i);
                %fpoint:pa=ca-cp
                fprintf('旋轉前CA座標:\n');
                disp([fpointX;fpointY]);
                fpointX=fpointX-fpointX(i);
                fpointY=fpointY-fpointY(i);
                fpoint=[fpointX;fpointY];
                %旋轉角度計算
                angle=atan(cpX/cpY);
                R=(cpX^2+cpY^2)^0.5;
                alpha=(g*sin(angle)*R+fvy/dt)/fI;
                omega=alpha*dt;
                sida=-omega*dt;
                fprintf('sida=%.2f\n',sida);
                %旋轉矩陣
                fprintf('原PA座標\n');
                disp(fpoint);
                fpoint_r=[cos(sida),-sin(sida);sin(sida),cos(sida)]*fpoint;
                fprintf('旋轉後PA座標\n');
                disp(fpoint_r);
                %pc'=mean(pa')
                fpcX=mean(fpoint_r(1,:));
                fpcY=mean(fpoint_r(2,:));
                %fpoint:c'a'=-pa'+pc'
                fpointX=fpoint_r(1,:)-fpcX;
                fpointY=fpoint_r(2,:)-fpcY;
                fprintf('旋轉後CA座標:\n');
                disp([fpointX;fpointY]);
                %oc'=oc+cp+pc'
                fprintf('原質心座標:(%.2f,%.2f)\n',fcx,fcy);
                fcx=fcx+cpX+fpcX;
                fcy=fcy+cpY+fpcY;
                fprintf('旋轉後質心座標:(%.2f,%.2f)\n',fcx,fcy);
            end
            %屬性更新
            obj.cx=fcx;
            obj.cy=fcy;
            obj.vx=fvx;
            obj.vy=fvy;
            obj.pointX=fpointX;
            obj.pointY=fpointY;
            %畫圖
            rockx=zeros(1,numel(obj.pointX))+obj.cz;
            figure(1),
            fill3([rockx+(-20),rockx,rockx+20],[obj.cx+obj.pointX/2,obj.cx+obj.pointX,obj.cx+obj.pointX/2],[obj.cy+obj.pointY/2,obj.cy+obj.pointY,obj.cy+obj.pointY/2],'k');
            
%             P = [[-50,rockx,50];[fcx,obj.cx+obj.pointX,fcx];[fcy,obj.cy+obj.pointY,fcy]];
%             plot3(P(:,1),P(:,2),P(:,3),'.')
%             axis equal
%             grid on
%             grid on;
            
%             shp = alphaShape([150,rockx,250]',[fcx,obj.cx+obj.pointX,fcx]',[fcy,obj.cy+obj.pointY,fcy]',1);
%             plot(shp)
        end
	end
end