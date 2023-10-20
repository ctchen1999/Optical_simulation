%% Leon Chen

%% Code Description
% Three sphere: uncomment second and third object below; eyes position maintain 
% as [1500; 0; 0] can get a better result.

% A plane and a sphere: uncomment first and fourth object below; eyes position
% maintain as [1500; 0; 300] can get a better result.

% A triangle: uncomment fifth object below; eyes position can set as
% [1500; 0; 0] can get a better result.


clear
tic
%% view
%eyes position
eyes = [1500; 0; 0]; % [x, y, z]
% window
window_width = 667; window_height = 667; % need to be odd numbers
window = zeros(window_height,window_width,3);
window_center = [500; 0; 0];

%% scene
% objects list define
OBJs = {};
% OBJs{i,1} -> object type
% OBJs{i,2} -> object

% % First object: red sphere
% OBJs{1,1} = 0;
% sphere1.center = [0; 0; -200];
% sphere1.radius = 200;
% sphere1.color = [1 0 0]; % red
% sphere1.smoothness = 0;
% OBJs{1,2} = sphere1;
% 
% % Second object: sphere
% OBJs{2,1} = 0;
% sphere2.center = [0; -200; -25];
% sphere2.radius = 150;
% sphere2.color = [0.7 0.7 0.7]; % gray
% sphere2.smoothness = 0;
% OBJs{2,2} = sphere2;
% 
% % Third object: sphere
% OBJs{3,1} = 0;
% sphere3.center = [0; 200; -25];
% sphere3.radius = 150;
% sphere3.color = [0.7 0.7 0.7]; % gray
% sphere3.smoothness = 0;
% OBJs{3,2} = sphere3;

% % Fourth object: plane
% OBJs{4,1} = 1; % 1 represent plane
% plane1.point = [0; 0; -200];
% plane1.normal = [0; 0; 1];
% plane1.color = [1 1 1]; % white
% plane1.smoothness = 0;
% OBJs{4,2} = plane1;

% Fifth object: triangle
% OBJs{5,1} = 2; % 2 represent triangle
% triangle1.point1 = [ 200; -200; -200];
% triangle1.point2 = [ 200; 200; -200];
% triangle1.point3 = [ 0; 0; 0];
% triangle1.normal = cross(triangle1.point2 - triangle1.point1, triangle1.point3- triangle1.point1);
% triangle1.color = [1 1 1]; % white
% triangle1.smoothness = 0;
% OBJs{5,2} = triangle1;

% lights list
LIGHTs = {};
light1.position = [350; 350; 150]; % [遠近, x, y]
light1.color = [1 1 1]; % white
LIGHTs{1} = light1;

%% go trace
% for every pixel
for i = 1:window_height 
    for j = 1:window_width
        cur_pix = window_center + [0; (window_width+1)/2; (window_height+1)/2] + [0; -j; -i];
        dir = cur_pix - eyes; 
        ray.origin = cur_pix;
        ray.direction = dir / norm(dir);
        window(i,j,:) = ray_trace(ray, OBJs, LIGHTs);
    end
end
       
%% forming image
%image(window);
imwrite(window,'test1.png');
toc