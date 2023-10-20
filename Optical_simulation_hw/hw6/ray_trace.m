function color = ray_trace(ray, OBJs, LIGHTs, depth)
%% variables
% ambient coefficient
A = 0.2;
% direct illumination color
ilumi = [0 0 0];
% refection color
reflect = [0 0 0];
% refraction color
refract = [0 0 0];

obj_smoothness = 0.2;

%% see if ray hits any object
hit = isblocked(ray, OBJs, inf);
%% if hit a surface
if hit{1} == 1
    % hit = {blocked, hit_point ,N, t, obj_color, obj_smoothness};
    hit_point = hit{2};
    N = hit{3};
    obj_color = hit{5};
    obj_smoothness = hit{6};

    V = (ray.origin - hit_point) / norm(ray.origin - hit_point);    

    for i = 1: length(LIGHTs)
        light = LIGHTs{i};
        % check if this point can reach the light
        L_d = (light.position - hit_point);
        tmp_ray.origin = hit_point;
        tmp_ray.direction = L_d/norm(L_d);
        shadow = isblocked(tmp_ray, OBJs, norm(L_d));
        
        % always do ambient
        ambient = A * obj_color .* light.color;
        ilumi = ilumi + ambient;
        % if not shadowed ->  do specular + diffuse
        if ~(shadow{1} == 1 && shadow{4} < norm(L_d))
            L = L_d / norm(L_d);
            ilumi = Phong_shading(N, L, V, obj_color, light) + ilumi;
        end
    end    
    
    % Reflection
    reflect = (2*(dot(N, tmp_ray.direction))*N - tmp_ray.direction)';
end
%% return
color = (1 - obj_smoothness) * ilumi + (obj_smoothness) * (reflect + refract);
% found if there is overflow
for i = 1:3
    if color(i) > 1
        color(i) = 1;
    end
end
end