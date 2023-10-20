function output = isblocked(ray, OBJs, t)
%% variables
% we need to step a extremely small first
% if we don't do so
% ray may be blocked by object at the origin
% due to limitation of data type "double"
ray.origin = ray.origin + 10^-5 * ray.direction;

% if hit any object
blocked = 0;
% hit position
hit_point = [0; 0; 0];
% normal at hit position
N = [0; 0; 0];
% object color at hit position
obj_color = [0 0 0];
%object smoothness at hit position
obj_smoothness = 0;

%% scan all objects
t_tmp = -1;
for i = 1: size(OBJs, 1)
    % object type indication
    if OBJs{i,1} == 0 % sphere
        t_tmp = RaySphereIntersect(ray, OBJs{i,2});
        hit_point_tmp = ray.origin + t_tmp*ray.direction;
        N_tmp = (hit_point_tmp - OBJs{i,2}.center) / norm(hit_point_tmp - OBJs{i,2}.center);
        color_tmp = OBJs{i,2}.color;
        smoothness_tmp = OBJs{i,2}.smoothness;
    elseif OBJs{i,1} == 1
        t_tmp = RayPlaneIntersection(ray, OBJs{i,2});
        hit_point_tmp = ray.origin + t_tmp*ray.direction;
        N_tmp = OBJs{i,2}.normal;
        color_tmp = OBJs{i,2}.color;
        smoothness_tmp = OBJs{i,2}.smoothness;
    elseif OBJs{i,1} == 2
        t_tmp = RayTriangleIntersection(ray, OBJs{i,2});
        hit_point_tmp = ray.origin + t_tmp*ray.direction;
        N_tmp = OBJs{i,2}.normal;
        color_tmp = OBJs{i,2}.color;
        smoothness_tmp = OBJs{i,2}.smoothness;
    end


    % if it is closer to the ray origin, record it
    if t_tmp < t && t_tmp > 0
        t = t_tmp;
        hit_point = hit_point_tmp;
        N = N_tmp;
        blocked = 1;
        obj_color = color_tmp;
        obj_smoothness = smoothness_tmp;
    end
        
end
%% return
output = {blocked, hit_point, N, t, obj_color, obj_smoothness};
end